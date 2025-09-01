#!/bin/bash
m=$(echo | bemenu -p "Minutes:")
[ -z "$m" ] && m=10
notify-send -u low "Timer set for $m min"
sleep $(echo "$m*60" | bc)
notify-send -u critical "Time's Up" "$m min timer completed"

