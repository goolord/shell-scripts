#! /usr/bin/env zsh
NUM_WINDOWS=$(yabai -m query --windows --space mouse | jq -c '[.[] | select (."is-floating" == false and ."is-visible" == true)] | length')

if [ "$NUM_WINDOWS" = "1" ] || [ "$NUM_WINDOWS" = "0" ]; then
    yabai -m config --space mouse window_border off
else
    yabai -m config --space mouse window_border on
fi
