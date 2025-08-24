#!/usr/bin/env bash
dir=$(tmux display-message -p -F "#{pane_current_path}")
cd "$dir" || return
url=$(git remote get-url origin)

# Convert SSH to HTTPS if needed
if [[ $url =~ ^git@([^:]+):(.+)\.git$ ]]; then
  url="https://${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
fi

# Strip .git from HTTPS if present
url=${url%.git}

# Open in browser
xdg-open "$url" >/dev/null 2>&1 &

