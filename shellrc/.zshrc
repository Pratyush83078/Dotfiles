# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# ── WORD STYLE ──────────────────────────────────────────────────────────────
autoload -Uz select-word-style
select-word-style bash

# ── OPTIONS ─────────────────────────────────────────────────────────────────
setopt PROMPT_SUBST autocd appendhistory sharehistory \
       hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_find_no_dups

# ── HISTORY ─────────────────────────────────────────────────────────────────
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# ── PROMPT (faster git branch via subprocess instead of vcs_info) ────────────
# vcs_info fires on every prompt even outside git repos — this is lighter
git_branch() { git symbolic-ref --short HEAD 2>/dev/null | sed 's/.*/ 🌙(&)/' }
PROMPT='%B%(?.%F{magenta}⚡.%F{red}💀)%f%b %B%F{cyan}%~%f%b%B%F{129}$(git_branch)%f%b %B%F{magenta}❯%f%b '
RPROMPT='%B%F{240}%T%f%b'
PS2='%B%F{129}┃%f%b '
PS4='%B%F{red}◢%f%b '

# ── ENV ─────────────────────────────────────────────────────────────────────
export PATH="$PATH:$HOME/.local/bin:$HOME/go/bin"
export EDITOR=nvim VISUAL=nvim
export XDG_CONFIG_HOME="$HOME/.config"

# ── ZINIT ───────────────────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

# Turbo mode: plugins load ~0ms after prompt appears (you won't notice the delay)
zinit wait lucid light-mode for \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab \
  zsh-users/zsh-syntax-highlighting   # load last — must be after others

# ── COMPLETIONS (cached — only rebuilds once per day) ─────────────────────
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then compinit
else compinit -C; fi

zinit cdreplay -q

# ── COMPLETION STYLE ─────────────────────────────────────────────────────
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --color=always {}'

# ── KEYBINDINGS ──────────────────────────────────────────────────────────
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ── ALIASES ──────────────────────────────────────────────────────────────
alias ls='exa --icons --color -s old'
alias tre='exa --tree --icons -s old --level'
alias c='clear'
alias movies='nvim ~/syncthing/testing/Movies.md'
alias b-off='sudo systemctl disable bluetooth && sudo systemctl stop bluetooth'
alias piano='mpv --no-terminal --force-window=no ~/Audio/Billy\ Joel\ -\ Piano\ Man\ \(Official\ Audio\).mp3 &'
alias neet='mpv ~/Videos/"Neetcode 150 Course - All Coding Interview Questions Solved.mp4"'
alias roaster='viu ~/Documents/gate27/4thSemTimeTable.jpeg'
alias gemini='node /home/prem/Downloads/bin/gemini-cli-0.1.7/bundle/gemini.js'

# ── FZF ──────────────────────────────────────────────────────────────────
eval "$(fzf --zsh)"

# ── BLUETOOTH ────────────────────────────────────────────────────────────
bt_connect() { sudo systemctl start bluetooth && bluetoothctl connect "$1"; }
alias rockerz='bt_connect "FC:58:FA:58:33:B5"'
alias nirvana='bt_connect "01:02:03:05:59:C8"'
alias dees='bt_connect "41:42:0B:1E:0D:7F"'
alias parmanu='bt_connect "41:42:D1:28:28:FD"'

# ── WIFI ─────────────────────────────────────────────────────────────────
wifi_connect() {
  nmcli r w on
  local args=("device" "wifi" "connect" "$1")
  [[ -n "$2" ]] && args+=("password" "$2")
  nmcli "${args[@]}"
}
alias railwire='wifi_connect "PRAMOD"'
alias z9='wifi_connect "iQOO Z9x 5G"'
alias iqoo='wifi_connect "iQOO Z7 5G"'
alias tbpg='wifi_connect "TBPG 1St floor"'
alias tbpg2='wifi_connect "The Boys PG-F2"'
alias cmf='wifi_connect "cmf" "piyushraj"'

# ── NAVIGATION ───────────────────────────────────────────────────────────
cd() { builtin cd "$@" || return; echo "$PWD" >> ~/.cd_history; }

shist() {
  local dir
  dir=$(tac ~/.cd_history | awk '!seen[$0]++' | sk --prompt="cd> " --margin=6,25 \
    --preview 'exa --icons --tree --level 1 --color=always {}') || return
  cd "$dir"
}
sdir() {
  while true; do
    local dir
    dir=$(fd . --type=dir --max-depth 2 -L | sk --prompt="cd> " --margin=6,25 \
      --preview 'exa --icons --tree --level 2 --color=always {}') || return
    cd "$dir"
  done
}
sroot() {
  local dir='/'
  while true; do
    dir=$(fd -a . "$dir" --type=dir --max-depth 2 -L | sk --prompt="cd> " --margin=6,25 \
      --preview 'ls --color=always {}') || return
    cd "$dir"
  done
}
ffc() {
  local selected
  selected=$(fd . . --type f --type d --exclude ".*" --exclude node_modules \
    --exclude __pycache__ --max-depth 3 | fzf --height=60% --layout=reverse \
    --border=rounded --prompt="🔍 " --pointer="▶" \
    --preview='[ -d {} ] && exa -1 --icons {} || bat --color=always -r :15 {}' \
    --preview-window=right:50%) || return
  [ -d "$selected" ] && cd "$selected" || xdg-open "$selected"
}
conf() {
  local selected
  selected=$(fd . ~/.config --type file \
    --exclude={VSCodium,thorium,pdfcpu,transmission,content_shell,Thorium,Electron,\
obs-studio,obsidian,libreoffice,GIMP,codeblocks,ghostty,Thunar,pulse,glib-2.0,dconf,yay} \
    | fzf --preview="bat --color=always --style=numbers,changes {}") || return
  nvim "$selected"
}

# ── FILES & MEDIA ─────────────────────────────────────────────────────────
notes() {
  local file
  file=$( (fd . ~/Documents/Notes -t f | cut -d'/' -f6-; echo "New") \
    | sk --color=bw --margin=5,35,15) || return
  [[ $file == "New" ]] && nvim ~/Documents/Notes/ || nvim ~/Documents/Notes/$file
}
todo() {
  local f=~/Documents/Notes/todos/$(date +%a).md
  mkdir -p ~/Documents/Notes/todos
  echo
  mdcat "$f" 2>/dev/null || echo "No todos for today!"
  read -s -k 1 key
  [[ "$key" == $'\n' || "$key" == $'\r' ]] && nvim "$f" || echo ""
}
spdf() {
  local select
  select=$(fd . -e pdf | sk --with-nth=-1 --delimiter=/) || return
  nohup zathura "$select" >/dev/null 2>&1 &
}
sfile() {
  local file
  file=$(fd . -t f --max-depth 3 -L | sk) || return
  file -L --mime "$file" | grep -q 'text/' && nvim "$file" || nohup xdg-open "$file" >/dev/null 2>&1 &
}
sv() { sudo -E nvim "$1"; }

# ── MEDIA DOWNLOAD ───────────────────────────────────────────────────────
dv() {
  local q=${2:-10000}
  yt-dlp -f "bv*[height<=${q}]+ba/b" --write-auto-sub --embed-subs \
    --embed-thumbnail --convert-thumbnails jpg -o "$HOME/Videos/%(title)s.%(ext)s" "$1"
}
dp() {
  local q=${2:-10000}
  yt-dlp -f "bv*[height<=${q}]+ba/b" --cookies-from-browser brave \
    --write-auto-sub --embed-subs --embed-thumbnail \
    -o "$HOME/Videos/%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s" "$1"
}
da() {
  yt-dlp -f ba -x --audio-format mp3 --embed-thumbnail --convert-thumbnails jpg \
    ${2:+--audio-quality "$2"} -o "$HOME/Audio/%(title)s.%(ext)s" "$1"
}

# UTILITIES ─────────────────────────────────────────────────────────────
ppt2pdf() {
  local out="../${PWD##*/}_pdf"
  mkdir -p "$out"
  libreoffice --headless --convert-to pdf --outdir "$out" *.(ppt|pptx)
}
timer() { sleep "$1" && dunstify -u critical "Timer: $1 done"; }
torr() { transmission-cli -u 0 -w "$HOME/Videos/Movies" "$1"; }
y() { local tmp="/tmp/yazi-cwd"; yazi "$@" --cwd-file="$tmp"; }
