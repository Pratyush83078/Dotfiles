#!/bin/bash
m=$(echo | bemenu -p "Minutes:")
[ -z "$m" ] && m=10
notify-send -u low "Timer set for $m min"
sleep $(echo "$m*60" | bc)
notify-send -u critical "Time's Up" "$m min timer completed"
paplay "$HOME/Documents/bin/bell_notify.wav" #mpg123 for mp3
