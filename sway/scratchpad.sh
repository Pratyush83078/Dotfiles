#!/bin/bash

state_file="/tmp/prev_workspace"

# Get current workspace
current_ws=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

if [ "$current_ws" = "10" ]; then
    if [ -f "$state_file" ]; then
        prev_ws=$(cat "$state_file")
        swaymsg workspace "$prev_ws"
    fi
else
    echo "$current_ws" > "$state_file"
    swaymsg workspace "10"
fi

