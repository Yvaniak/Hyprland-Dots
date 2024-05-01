#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Monitor backlights (if supported) using brightnessctl

iDIR="$HOME/.config/swaync/icons"
notification_timeout=1000

limit=20
above="10%"
under="2%"

# Get brightness
get_backlight() {
	echo $(brightnessctl -m | cut -d, -f4)
}

# Get icons
get_icon() {
	current=$(get_backlight | sed 's/%//')
	if   [ "$current" -le "20" ]; then
		icon="$iDIR/brightness-20.png"
	elif [ "$current" -le "40" ]; then
		icon="$iDIR/brightness-40.png"
	elif [ "$current" -le "60" ]; then
		icon="$iDIR/brightness-60.png"
	elif [ "$current" -le "80" ]; then
		icon="$iDIR/brightness-80.png"
	else
		icon="$iDIR/brightness-100.png"
	fi
}

# Notify
notify_user() {
	notify-send -e -h string:x-canonical-private-synchronous:brightness_notif -h int:value:$current -u low -i "$icon" "Brightness : $current%"
}

# Change brightness
change_backlight() {
	brightnessctl set "$1" && get_icon && notify_user
}

# Execute accordingly
case "$1" in
    "--get") 
            get_backlight 
            ;; 
    "--inc")
            if [[ $($HOME/.config/hypr/scripts/Brightness.sh --get | cut -d% -f1) -lt $limit ]] 
            then  
                    perc=$under
            else
                    perc=$above
            fi
            echo $perc
            change_backlight "+"$perc

            ;;
    "--dec")
            if [[ $($HOME/.config/hypr/scripts/Brightness.sh --get | cut -d% -f1) -le $limit ]]
            then
                    perc=$under
            else
                    perc=$above
            fi
            echo $perc
            change_backlight $perc"-"
            ;;
    *)
            get_backlight
            ;;
esac
