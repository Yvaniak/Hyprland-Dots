#!/usr/bin/env bash
export STATE_FILE=~/.config/hypr/scripts/state
if [[ -e $STATE_FILE ]]; then
	light=$(cat $STATE_FILE)
	$(brightnessctl s $light)
	rm $STATE_FILE
	echo "tata"
else
	brightnessctl g > $STATE_FILE
	brightnessctl s 0%
	echo "test"
fi
