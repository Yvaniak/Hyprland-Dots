#!/bin/bash

if [[ -e ~/scripts/state ]]; then
	light=$(cat ~/scripts/state)
	$(brightnessctl s $light)
	rm ~/scripts/state
	echo "tata"
else
	$(brightnessctl g > ~/scripts/state)
	$(brightnessctl s 0%)
	echo "test"
fi
