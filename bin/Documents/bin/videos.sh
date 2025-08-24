#!/bin/bash

Exclude=(
  # "$HOME/Videos/telegram/harkirat3.0/"
  "$HOME/Videos/telegram/harkirat2.0/"
  "$HOME"
  )
  echo $(Exclude)
dir_selected=$(fd . "$HOME/Videos/" --type=dir -d 2 -E "harkirat2.0" \
          | sed "s|^$HOME/Videos/||" \
          | sk )
[[ -z $dir_selected ]] && exit 0
video_path=$(echo "$HOME/Videos/$dir_selected")
file_selected=$(fd . "$video_path" \
  |  sed "s|$video_path||g" | sk )

[[ -z $file_selected ]] && exit 0

mpv "$video_path$file_selected"
