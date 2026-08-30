#!/bin/bash

# ==============================================================================
# macOS Copy Last Notification
#
# A script to extract the most recent macOS notification and copy its text
# to the clipboard.
# ==============================================================================

set -euo pipefail

# Check for Full Disk Access before running
DB_PATH="$HOME/Library/Group Containers/group.com.apple.usernoted/db2/db"
if [ ! -f "$DB_PATH" ]; then
    DB_PATH="$(getconf DARWIN_USER_DIR)com.apple.notificationcenter/db2/db"
fi

if ! sqlite3 "$DB_PATH" "SELECT 1;" >/dev/null 2>&1; then
    echo "ERROR: Operation not permitted. Your terminal (or Raycast) lacks Full Disk Access." >&2
    exit 1
fi

# Run an inline Python script to properly parse the binary plist and NSKeyedArchiver objects
TEXT=$(python3 -c '
import sqlite3
import plistlib
import sys
import os

db_path = os.path.expanduser("~/Library/Group Containers/group.com.apple.usernoted/db2/db")
if not os.path.exists(db_path):
    import subprocess
    darwin_dir = subprocess.getoutput("getconf DARWIN_USER_DIR")
    db_path = os.path.join(darwin_dir, "com.apple.notificationcenter/db2/db")

def extract_strings(obj):
    strings = []
    if isinstance(obj, str):
        strings.append(obj)
    elif isinstance(obj, dict):
        for v in obj.values():
            strings.extend(extract_strings(v))
    elif isinstance(obj, list):
        for item in obj:
            strings.extend(extract_strings(item))
    return strings

try:
    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    # We select all records ordered by newest first
    c.execute("SELECT data FROM record ORDER BY delivered_date DESC;")
    
    ignore_exact = {
        "NSMutableDictionary", "NSDictionary", "NSObject", "LEGACY", "ACTION", 
        "NS.keys", "NS.objects", "$null", "req", "styl", "app", "uuid", "resp", 
        "srce", "date", "orig", "act", "for", "dest", "body", "ddac", "scat", 
        "titl", "usda", "id", "opt", "acts", "NSKeyedArchiver", "NSMutableString",
        "NSString"
    }
    ignore_prefixes = (
        "fr.julienxx.", "com.apple.", "org.", "net.", "$", "NS"
    )

    for row in c:
        blob = row[0]
        if not blob:
            continue
        
        # Strip any proprietary Apple headers before the standard bplist00 magic bytes
        idx = blob.find(b"bplist00")
        if idx != -1:
            blob = blob[idx:]
            
        try:
            plist = plistlib.loads(blob)
            all_strings = extract_strings(plist)
            
            valid_strings = []
            for s in all_strings:
                val = s.strip()
                if not val or val in ignore_exact:
                    continue
                if val.startswith(ignore_prefixes):
                    continue
                valid_strings.append(val)
                
            # If we successfully extracted meaningful text from this record, print and exit
            if valid_strings:
                for s in valid_strings:
                    print(s)
                sys.exit(0)
                
        except Exception:
            # If parsing fails for a specific blob, continue to the next most recent one
            continue

except Exception as e:
    print(f"Error reading database: {e}", file=sys.stderr)
    sys.exit(1)
')

if [ -z "$TEXT" ]; then
    echo "ERROR: No notification text could be extracted." >&2
    exit 1
fi

# Copy to clipboard
echo "$TEXT" | pbcopy
echo "Last notification copied:"
echo "$TEXT"
