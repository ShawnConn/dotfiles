#!/bin/bash

# ==============================================================================
# macOS Toggle Head Mouse
#
# A script to toggle the macOS Alternate pointer actions & Head pointer
# accessibility options.
# ==============================================================================

set -euo pipefail

# ANSI colors
if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
else
    GREEN=''
    NC=''
fi

# Allow defaults read to fail if the key doesn't exist yet
set +e
state=$(defaults read com.apple.universalaccess headMouseEnabled 2>/dev/null)
#state=$(defaults read com.apple.universalaccess alternateMouseButtonsEnabled 2>/dev/null)
set -e

if [ "$state" = "1" ]; then
    # Disable Head Pointer and
    defaults write com.apple.universalaccess headMouseEnabled -bool false

    # Alternate Pointer Actions
    defaults write com.apple.universalaccess alternateMouseButtonsEnabled -bool false
    # Clean up the scrollbar overrides
    defaults delete com.apple.universalaccess scrollBarOverrideIdentifiers 2>/dev/null
    defaults delete com.apple.universalaccess scrollBarOverrideOriginalValue 2>/dev/null

    #echo -e "${GREEN}Alternate Pointers disabled.${NC}"
    echo -e "${GREEN}Head & Alternate Pointers disabled.${NC}"
    osascript -e 'display notification "Head pointer has been turned off." with title "Head Pointer Disabled"'
else
    # Enable Head Pointer and Alternate Pointer Actions
    defaults write com.apple.universalaccess headMouseEnabled -bool true

    # Alternate Pointer Actions
    defaults write com.apple.universalaccess alternateMouseButtonsEnabled -bool true
    # Set the scrollbar overrides
    defaults write com.apple.universalaccess scrollBarOverrideIdentifiers -array "UAEHPointerControlDriver"
    defaults write com.apple.universalaccess scrollBarOverrideOriginalValue -string "WhenScrolling"
    #echo -e "${GREEN}Alternate Pointers enabled.${NC}"
    echo -e "${GREEN}Head & Alternate Pointers enabled.${NC}"
    osascript -e 'display notification "Camera tracking will begin in ~10-15s..." with title "Head Pointer Enabled"'
fi

# Force restart the background agents to apply changes immediately
# Note: universalaccessd takes ~10-15s to fully respawn and apply the Head Pointer
set +e
killall MotionTrackingAgent 2>/dev/null
killall AccessibilityVisualsAgent 2>/dev/null
killall universalaccessd 2>/dev/null
set -e
