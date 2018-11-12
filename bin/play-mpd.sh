#!/bin/bash
CURRENT=`mpc current`
if [ -z "$CURRENT" ]; then
# If no music is being played or is paused
    mpc clear
    mpc load All
    mpc shuffle
    mpc repeat on
    mpc random on
    mpc play
else
    mpc toggle
fi
