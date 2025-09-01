# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
autoload -Uz select-word-style
select-word-style bash

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' 🌙(%b)'
zstyle ':vcs_info:*' enable git

setopt PROMPT_SUBST

PROMPT='%B%(?.%F{magenta}⚡.%F{red}💀)%f%b %B%F{cyan}%~%f%b%B%F{129}${vcs_info_msg_0_}%f%b %B%F{magenta}❯%f%b '

RPROMPT='%B%F{240}%T%f%b'

PS2='%B%F{129}┃%f%b '
PS4='%B%F{red}◢%f%b '

export LS_COLORS='di=1;35:fi=0;37:ln=1;36:pi=40;33:so=1;35:do=1;35:bd=40;33;1:cd=40;33;1:or=40;31;1:ex=1;32:*.tar=1;31:*.tgz=1;31:*.zip=1;31:*.jpg=1;33:*.jpeg=1;33:*.png=1;33:*.gif=1;33:*.mp3=1;34:*.mp4=1;34:*.avi=1;34'

alias ls='exa --icons --color=automatic  -s old '
alias tre='exa --tree --icons -s old --level '
notes() {
  local file=$(fd . /home/prem/Documents/Notes -t f | cut -d'/' -f6- | sk --color=bw --margin=5,35,15 )
  [[ -z $file ]] && return;
   nvim "/home/prem/Documents/Notes/$file"
}
spdf() {
  local select
  select=$(fd . -e pdf | sk --with-nth=-1 --delimiter /) || return
  [[ -z $select ]] && return
  nohup zathura "$select" >/dev/null 2>&1 &
}
sfile() {
  local file
  file=$(fd . -t f --max-depth 3 -L | sk) || return

  if file -L --mime "$file" | grep -q 'text/'; then
    nvim "$file"
  else
    nohup xdg-open "$file" >/dev/null 2>&1 &
  fi
}
sdir() {
  while true; do
    local dir
    dir=$(fd . --type=dir --max-depth 3  -L | sk) || return
    cd "$dir" || return
  done
}
vim() {
  NVIM_APPNAME="nvim.bak" nvim $1
}
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
#zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"


export PATH="$PATH:$HOME/.local/bin:$HOME/go/bin"
export EDITOR="nvim"
export VISUAL="nvim"
export XDG_CONFIG_HOME="$HOME/.config"


alias movies='nvim ~/syncthing/testing/Movies.md'

# System controls
alias b-off='sudo systemctl disable bluetooth && sudo systemctl stop bluetooth'
# Entertainment
alias piano='mpv --no-terminal --force-window=no ~/Audio/Billy\ Joel\ -\ Piano\ Man\ \(Official\ Audio\).mp3 &'

# ============================================================================
# BLUETOOTH CONNECTIONS
# ============================================================================
bt_connect() { sudo systemctl start bluetooth && bluetoothctl connect "$1"; }
alias rockerz='bt_connect "FC:58:FA:58:33:B5"'
alias nirvana='bt_connect "01:02:03:05:59:C8"'
alias dees='bt_connect "41:42:0B:1E:0D:7F"'
alias parmanu='bt_connect "41:42:D1:28:28:FD"'

# ============================================================================
# WIFI CONNECTIONS
# ============================================================================
wifi_connect() {
  nmcli r w on
  local args=("device" "wifi" "connect" "$1")
  if [[ -n "$2" ]]; then
    args+=("password" "$2")
  fi
  nmcli "${args[@]}"
}
alias railwire='wifi_connect "PRAMOD" "pmsrs1999"'
alias z9='wifi_connect "iQOO Z9x 5G"'
alias iqoo='wifi_connect "iQOO Z7 5G"'
alias tbpg='wifi_connect "TBPG 1St floor"'
# alias hostel='wifi_connect "EduHostelMdu" "Pratyush@123"'

# ============================================================================
# FUNCTIONS
# ============================================================================

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
# fk() {
#   local pid=$(ps aux | grep -v grep |
#     fzf --height=50% --layout=reverse --border --prompt="💀 Kill: " --header="Tab:select Enter:kill" \
#       --preview='echo {}' --preview-window=down:3 | awk '{print $2}')
#   [ -n "$pid" ] && kill "$pid" && echo "Killed process $pid"
# }
# Set this only once in your shell config
sv() {
  sudo -E nvim $1
}
