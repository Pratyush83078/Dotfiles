#!/usr/bin/env bash

histfile="$HOME/.cache/cliphist"
pinnedfile="$HOME/.clip_history"
placeholder='<NEWLINE>'
MENU=bemenu
write() {
    clip=$(wl-paste -n 2>/dev/null || echo "")
    [ -z "$clip" ] && return
    multiline="${clip//$'\n'/$placeholder}"
    mkdir -p "$(dirname "$histfile")"
    touch "$histfile"
    if grep -Fxq "$multiline" "$histfile"; then
        exit 0
    else
        echo "$multiline" >> "$histfile"
        notify-send "Added to history:" "${clip:0:60}" -t 700
    fi
}

sel() {
    selection=$(
        {
            if [ -s "$pinnedfile" ]; then
                tac "$pinnedfile"
                echo "--------------Pinned_history END----------------------"
            fi
            tac "$histfile"
        } | $MENU -l 20 -i -p "Clip hist: "
    )
    [ -z "$selection" ] && return
    [[ "$selection" == *"Pinned_history END"* ]] && return
    printf '%s' "${selection//"$placeholder"/$'\n'}" | wl-copy
    notify-send "Copied to clipboard"
}

clear_hist() {
  rm $histfile 
}

case "$1" in
    add) write ;;
    sel) sel ;;
    clear) clear_hist ;;
    *) echo "$0 | File: $histfile"; echo "add - save clipboard"; echo "sel - choose from history"; exit ;;
esac
