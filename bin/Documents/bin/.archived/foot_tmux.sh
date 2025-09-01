#!/bin/bash
NEW="$(date +%H_%M)"
foot_tmux=$(swaymsg -t get_tree | grep  "app_id.*foot_tmux")

if [ -n "$foot_tmux" ]; then
  swaymsg '[app_id="foot_tmux"]' kill
  foot --app-id=foot_tmux tmux new-session -A -s $NEW
else
  foot --app-id=foot_tmux tmux new-session -A -s $NEW
fi
