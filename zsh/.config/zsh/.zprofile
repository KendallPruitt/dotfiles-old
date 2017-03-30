export PATH="/usr/lib/cw:$PATH"
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx