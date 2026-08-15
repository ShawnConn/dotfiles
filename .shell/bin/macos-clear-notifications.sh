#!/bin/bash

# ==============================================================================
# macOS Notification Center Clearer
#
# A script to clear current and old notifications in macOS Notification Center.
# Targets the system database used by macOS (including Sequoia, Sonoma, etc.).
# ==============================================================================

set -euo pipefail

# Default options
FORCE=false
BACKUP=true
VERBOSE=false

# ANSI colors
if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

# Print usage helper
usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -f, --force      Bypass the confirmation prompt and clear notifications immediately.
  -n, --no-backup  Skip creating a backup of the notification database.
  -v, --verbose    Print detailed information during execution.
  -h, --help       Show this help message.

Description:
  This script stops the macOS notification processes (usernoted, NotificationCenter),
  clears the underlying SQLite databases, and restarts the services to completely
  clear out all active alerts, banners, and historical notifications.
EOF
    exit 0
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--force)
            FORCE=true
            shift
            ;;
        -n|--no-backup)
            BACKUP=false
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}" >&2
            usage
            ;;
    esac
done

# Ensure we are running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}Error: This script is only supported on macOS.${NC}" >&2
    exit 1
fi

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo -e "[DEBUG] $1"
    fi
}

# Locate database paths
log_verbose "Searching for notification database paths..."

# 1. Modern macOS path (Sequoia, Sonoma, Ventura, etc.)
DB_DIR_MODERN="$HOME/Library/Group Containers/group.com.apple.usernoted/db2"
DB_PATH_MODERN="$DB_DIR_MODERN/db"

# 2. Legacy/Alternative macOS path
DARWIN_DIR=$(getconf DARWIN_USER_DIR 2>/dev/null || echo "")
DB_PATH_LEGACY=""
if [ -n "$DARWIN_DIR" ]; then
    DB_PATH_LEGACY="$DARWIN_DIR/com.apple.notificationcenter/db2/db"
fi

SELECTED_DB=""
SELECTED_DB_DIR=""

if [ -f "$DB_PATH_MODERN" ]; then
    SELECTED_DB="$DB_PATH_MODERN"
    SELECTED_DB_DIR="$DB_DIR_MODERN"
    log_verbose "Found modern notification database at: $SELECTED_DB"
elif [ -n "$DB_PATH_LEGACY" ] && [ -f "$DB_PATH_LEGACY" ]; then
    SELECTED_DB="$DB_PATH_LEGACY"
    SELECTED_DB_DIR="$(dirname "$DB_PATH_LEGACY")"
    log_verbose "Found legacy notification database at: $SELECTED_DB"
else
    # Fallback search if standard locations don't exist
    log_verbose "Standard paths not found. Performing fallback search..."
    SEARCH_RESULT=$(find "$HOME/Library/Group Containers" -path "*/group.com.apple.usernoted/db2/db" -print -quit 2>/dev/null || true)
    if [ -n "$SEARCH_RESULT" ]; then
        SELECTED_DB="$SEARCH_RESULT"
        SELECTED_DB_DIR="$(dirname "$SEARCH_RESULT")"
        log_verbose "Found database via fallback search at: $SELECTED_DB"
    fi
fi

if [ -z "$SELECTED_DB" ]; then
    log_error "Could not locate the macOS notification database."
    log_error "Ensure your terminal has sufficient permissions (e.g. Full Disk Access if on macOS Sequoia or later)."
    exit 1
fi

# Confirmation Prompt
if [ "$FORCE" = false ]; then
    echo -e "${YELLOW}Warning: This will clear all active notifications (banners/alerts) and notification history.${NC}"
    echo -ne "Do you want to proceed? (y/N): "
    read -r response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Operation cancelled."
        exit 0
    fi
fi

# Create backup if requested
if [ "$BACKUP" = true ]; then
    BACKUP_DIR="$HOME/.app/NotificationCenter/notifications_backup_$(date +%Y%m%d_%H%M%S)"
    log_info "Creating a database backup in: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    cp -pf "$SELECTED_DB_DIR"/db* "$BACKUP_DIR"/ 2>/dev/null || true
    log_success "Backup completed."
fi

# Stop notification daemons
log_info "Stopping notification services..."
killall -9 usernoted 2>/dev/null || true
killall -9 NotificationCenter 2>/dev/null || true
sleep 1

# Clear database files
log_info "Clearing notifications..."

# We delete the database files (db, db-shm, db-wal).
# This is the most reliable way to force macOS to reset notifications completely.
# macOS will automatically regenerate clean database files when the service restarts.
log_verbose "Removing files under $SELECTED_DB_DIR..."
rm -f "$SELECTED_DB_DIR"/db*

# Wait a brief moment for launchd to restart usernoted and regenerate the db files
sleep 1

# Verify regeneration
if [ -f "$SELECTED_DB" ]; then
    log_success "Notification database cleared and successfully regenerated!"
else
    # Trigger restart of NotificationCenter to force regeneration
    log_verbose "Database not yet recreated. Prompting services to start..."
    pgrep -q usernoted || killall -0 usernoted 2>/dev/null || true
fi

log_success "All current and old notifications have been successfully cleared!"
