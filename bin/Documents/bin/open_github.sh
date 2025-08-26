#!/bin/bash

dir=$(tmux display-message -p -F "#{pane_current_path}")
cd "$dir" || return
url=$(git remote get-url origin)
(echo $url | grep -q "git@github")
if [ $? -eq 0 ]; then
  url=${url%.git}
  full_repo_path="https://github.com/${url##*:}"
else
  full_repo_path="$url"
fi
# url=${url%.git}

xdg-open "$full_repo_path" 
tmux display-popup -C 
