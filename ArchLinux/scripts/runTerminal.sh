#!/bin/bash
if wmctrl -lx | grep -i alacritty; then
  wmctrl -xa Alacritty
else
  alacritty &
fi
