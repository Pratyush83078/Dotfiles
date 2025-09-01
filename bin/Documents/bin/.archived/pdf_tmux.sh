#!/bin/bash
PDF=(
  "$HOME/Documents/Pdf/"
  "$HOME/Downloads/"
  # "$HOME/Documents/Dsa/"
  )


selected=$(fd . ${PDF[@]} -e .pdf | sed "s|^$HOME/||" | sk --margin=2 --color=bw)

[[ -z $selected ]] && exit 0;
[[ $selected ]] && selected="$HOME/$selected"

nohup zathura "$selected" >/dev/null 2>&1 &
tmux display-pop -C
