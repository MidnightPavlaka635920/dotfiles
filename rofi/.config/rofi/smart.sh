#!/bin/sh

if [ -f "$1" ] || [ -d "$1" ]; then
  env XDG_CURRENT_DESKTOP=Hyprland \
    XDG_SESSION_TYPE=wayland \
    gio open "$1"
else
  exec "$@"
fi

