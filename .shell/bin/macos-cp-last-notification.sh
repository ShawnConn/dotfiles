#!/bin/bash

# ==============================================================================
# macOS Copy Visible Notifications (AppleScript UI Scripting Edition)
#
# A script to extract the text of currently visible macOS notifications
# (banners or alerts) by directly reading the UI hierarchy via System Events.
# This completely bypasses the broken macOS 15 SQLite database logging.
# ==============================================================================

set -euo pipefail

# To avoid macOS Bash 3.2 parsing bugs with heredocs inside command substitutions,
# we write the AppleScript to a temporary file first.
AS_FILE=$(mktemp)
cat << 'EOF' > "$AS_FILE"
-- A recursive handler to dig through the Notification Center UI and extract all text
on getText(uiElem)
    tell application "System Events"
        set results to {}
        
        -- If this element is a text label, grab its value
        if class of uiElem is static text then
            set v to value of uiElem
            if v is not missing value and v is not "" then
                set end of results to v
            end if
        end if
        
        -- Recursively dig into children (groups, scroll areas, etc.)
        try
            set children to UI elements of uiElem
            repeat with child in children
                set childResults to my getText(child)
                set results to results & childResults
            end repeat
        end try
        
        return results
    end tell
end getText

tell application "System Events"
    if exists process "NotificationCenter" then
        tell process "NotificationCenter"
            -- Banners and alerts live in the "Notification Center" window
            if exists window "Notification Center" then
                set rawList to my getText(window "Notification Center")
                
                if (count of rawList) > 0 then
                    set AppleScript's text item delimiters to "\n"
                    return rawList as string
                end if
            end if
        end tell
    end if
    
    return "ERROR_NO_VISIBLE_NOTIFICATIONS"
end tell
EOF

TEXT=$(osascript "$AS_FILE")
rm -f "$AS_FILE"

if [[ "$TEXT" == "ERROR_NO_VISIBLE_NOTIFICATIONS" ]]; then
    echo "ERROR: No visible notifications found on screen." >&2
    echo "Note: This script reads directly from active banners. The notification must currently be visible on your screen." >&2
    exit 1
fi

if [ -z "$TEXT" ]; then
    echo "ERROR: Could not extract text from notifications." >&2
    exit 1
fi

# Copy to clipboard
echo "$TEXT" | pbcopy
echo "Successfully copied visible notifications:"
echo "$TEXT"
