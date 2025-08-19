# ~/.bashrc - Optimized configuration
# ~/.bashrc RubyRussel-like theme
# Colors
#PS1='\[\033[1m\]\[\033[32m\]$(if [ $? = 0 ]; then echo "⚡"; else echo "\[\033[31m\]✗"; fi)\[\033[0m\] \[\033[1;36m\]\W\[\033[0m\] \[\033[1;33m\]$(git branch 2>/dev/null | grep "^*" | cut -d" " -f2 | sed "s/.*/ (&)/")\[\033[0m\]\[\033[1m\]❯\[\033[0m\] '
PS1='\[\033[1;35m\]$(if [ $? = 0 ]; then echo "⚡"; else echo "\[\033[31m\]✗" ; fi)\[\033[0m\] \[\033[1;36m\]\w\[\033[0m\]\[\033[1;38;5;129m\]$(git branch 2>/dev/null | grep "^*" | cut -d" " -f2 | sed "s/.*/ 🌙(&)/")\[\033[0m\] \[\033[1;35m\]❯\[\033[0m\] '
export LS_COLORS='di=1;35:fi=0;37:ln=1;36:pi=40;33:so=1;35:do=1;35:bd=40;33;1:cd=40;33;1:or=40;31;1:ex=1;32:*.tar=1;31:*.tgz=1;31:*.zip=1;31:*.jpg=1;33:*.jpeg=1;33:*.png=1;33:*.gif=1;33:*.mp3=1;34:*.mp4=1;34:*.avi=1;34'

alias ls='exa --icons --color=automatic  -s old '
alias lf='exa --icons -la -f -s old --grid '
alias tre='exa --tree --icons -s old --level '
PS2='\[\033[1;38;5;129m\]┃ \[\033[0m\]'
PS4='\[\033[1;31m\]◢ \[\033[0m\]'
# Exit if not interactive
[[ $- != *i* ]] && return

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
export PATH="$PATH:$HOME/.local/bin:$HOME/go/bin"
export EDITOR="nvim"
export VISUAL="nvim"
export XDG_CONFIG_HOME="$HOME/.config"


# History configuration
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="ls:cd:pwd:neofetch*:history:clear:exit"
export PROMPT_COMMAND='history -a; history -n'

# ============================================================================
# SHELL OPTIONS & BINDINGS
# ============================================================================
shopt -s histappend autocd cdspell
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind "set visible-stats on"

# ============================================================================
# PROMPT SETUP
# ============================================================================
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Colorized prompt with git branch
#PS1="\[\033[0;34m\]\w\[\033[0;33m\]\$(parse_git_branch) \[\033[0;32m\]\$ \[\033[0m\]"

# ============================================================================
# BASIC ALIASES
# ============================================================================
alias grep='grep --color=auto'

# Development
alias testing='nvim $HOME/test.c'
alias tested='clang test.c && ./a.out'
alias movies='nvim ~/syncthing/testing/Movies.md'

# System controls
alias b-on='sudo systemctl start bluetooth'
alias b-off='sudo systemctl disable bluetooth && sudo systemctl stop bluetooth'
alias t-on='sudo modprobe psmouse'
alias t-off='sudo modprobe -r psmouse'
alias w-off='nmcli r w off'

# Entertainment
alias piano='mpv --no-terminal --force-window=no ~/Audio/Billy\ Joel\ -\ Piano\ Man\ \(Official\ Audio\).mp3 &'

# ============================================================================
# BLUETOOTH CONNECTIONS
# ============================================================================
bt_connect() { sudo systemctl start bluetooth && bluetoothctl connect "$1"; }
alias rockerz='bluetoothctl connect "FC:58:FA:58:33:B5"'
alias nirvana='bt_connect "01:02:03:05:59:C8"'
alias dees='bt_connect "41:42:0B:1E:0D:7F"'
alias parmanu='bt_connect "41:42:D1:28:28:FD"'

# ============================================================================
# WIFI CONNECTIONS
# ============================================================================
wifi_connect() { nmcli r w on && nmcli d w c "$1" ${2:+password "$2"}; }
alias railwire='wifi_connect "PRAMOD RAILWIRE" "pmsrs1999'
alias pg='wifi_connect "TBPG 1St floor" '
alias z9='wifi_connect "iQOO Z9x 5G"'
alias iqoo='wifi_connect "iQOO Z7 5G"'
alias hostel='wifi_connect "EduHostelMdu" "Pratyush@123"'

# ============================================================================
# FUNCTIONS
# ============================================================================

# Project management
notes() {
  nvim $HOME/notes/$1
}
code() {
  cd ~/webProjects/ || return
  [[ -d "$1" ]] && cd "$1" || { mkdir "$1" && cd "$1"; }
  codium ./
}

# Backup configuration
bak-forLinux() {
  local repo="$HOME/Documents/forLinux"
  local files=(
    "$HOME/.bashrc:."
    "$HOME/.config/sway:."
    "$HOME/.config/dunst/dunstrc:."
    "$HOME/.config/tofi:."
    "$HOME/.local/bin:."
    "$HOME/.mozilla/firefox/4qatbcuy.default-release/chrome/:."
    "$HOME/.mozilla/firefox/4qatbcuy.default-release/user.js:."
  )

  for file_mapping in "${files[@]}"; do
    src="${file_mapping%:*}"
    [[ -e "$src" ]] && cp -r "$src" "$repo/"
  done

  git -C "$repo" add .
  read -p "Commit message (default: automated backup): " msg
  git -C "$repo" commit -m "${msg:-automated backup}"
  git -C "$repo" push origin main
}

# Media download functions
dv() {
  local quality=${2:-$(read -p "Video quality (or Enter for best): " && echo "$REPLY")}
  yt-dlp -f "bv*[height<=${quality:-10000}]+ba/b" \
    --write-auto-sub --embed-subs --embed-thumbnail --convert-thumbnails jpg \
    -o "$HOME/Videos/%(title)s.%(ext)s" "$1"
}

dp() {
  local quality=${2:-$(read -p "Video quality (or Enter for best): " && echo "$REPLY")}
  yt-dlp -f "bv*[height<=${quality:-10000}]+ba/b" \
    --cookies ~/Documents/www.youtube.com_cookies.txt \
    --write-auto-sub --embed-subs --embed-thumbnail \
    -o "$HOME/Videos/%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s" "$1"
}
da() {
  local quality=${2:-$(read -p "Audio quality (6-0, or Enter for best): " && echo "$REPLY")}
  yt-dlp -f "ba" -x --audio-format mp3 --embed-thumbnail \
    --convert-thumbnails jpg --add-metadata ${quality:+--audio-quality "$quality"} \
    -o "$HOME/Audio/%(title)s.%(ext)s" "$1"
}

# Utility functions
timer() { sleep "$1" && dunstify -u critical "Timer completed: $1"; }
alert() { echo "dunstify -u critical 'Alert' 'Time to check your schedule'" | at "$1"; }
torr() { transmission-cli -u 0 -w "$HOME/Videos/Movies" "$1"; }
#gemini() {
#   node /home/prem/downloads/gemini-cli-0.1.7/bundle/gemini.js "$@"
#}
alias gemini='node /home/prem/Downloads/gemini-cli-0.1.7/bundle/gemini.js'
y() {
  local tmp="/tmp/yazi-cwd"
  yazi "$@" --cwd-file="$tmp"
}

ffc() {
  local selected
  if command -v fd >/dev/null 2>&1; then
    selected=$((fd . . --type f --type d --exclude ".*" --exclude node_modules --exclude __pycache__ --max-depth 3) |
      fzf --height=60% --layout=reverse --border=rounded --color="hl:#7aa2f7,fg+:#c0caf5,bg+:#292e42" \
        --prompt="🔍 " --pointer="▶" --preview='
            if [ -d {} ]; then exa -1 --icons {} 2>/dev/null | head -15
            else file {} && echo "---" && bat --color=always -r :15 {} 2>/dev/null || head -10 {}; fi
          ' --preview-window=right:50%)
  else
    selected=$(find . \( -name ".*" -o -name node_modules -o -name __pycache__ \) -prune -o -type f -print -o -type d -print |
      fzf --height=60% --layout=reverse --border --prompt="🔍 " --preview='[ -d {} ] && ls -1 {} || head -10 {}')
  fi
  [ -n "$selected" ] && { [ -d "$selected" ] && cd "$selected" || xdg-open "$selected"; }
}

hg() {
local result=$(history | tac | awk '{$1=""; sub(/^ /, ""); print}' | awk '!seen[$0]++' |
    fzf --height=40% --layout=reverse --border=rounded --prompt="📜 History: " --color="hl:#7aa2f7")
  if [ -n "$result" ]; then
    READLINE_LINE="$result"
    READLINE_POINT=${#READLINE_LINE}
  fi
}
bind -x '"\C-f": hg'

conf() {
  local selected
  selected=$(fd . ~/.config --type file \
    --exclude VSCodium \
    --exclude thorium \
    --exclude pdfcpu \
    --exclude transmission \
    --exclude content_shell \
    --exclude Thorium \
    --exclude Electron \
    --exclude obs-studio \
    --exclude obsidian \
    --exclude libreoffice \
    --exclude GIMP \
    --exclude codeblocks \
    --exclude ghostty \
    --exclude Thunar \
    --exclude pulse \
    --exclude glib-2.0 \
    --exclude dconf \
    --exclude yay | fzf --preview="bat --color=always --style=numbers,changes {}" )
  [ -n "$selected" ] && nvim "$selected"
}

# History and command search
# Process search and kill
fk() {
  local pid=$(ps aux | grep -v grep |
    fzf --height=50% --layout=reverse --border --prompt="💀 Kill: " --header="Tab:select Enter:kill" \
      --preview='echo {}' --preview-window=down:3 | awk '{print $2}')
  [ -n "$pid" ] && kill "$pid" && echo "Killed process $pid"
}
