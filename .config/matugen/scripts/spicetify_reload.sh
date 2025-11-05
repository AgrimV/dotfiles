#!/bin/bash

if pgrep -x spotify > /dev/null; then
    was_running=true
else
    was_running=false
fi

~/.spicetify/spicetify refresh

if [ "$was_running" = true ]; then
    killall spotify
    flatpak run com.spotify.Client > /dev/null 2>&1
fi
