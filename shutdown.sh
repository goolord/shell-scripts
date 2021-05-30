#!/bin/sh

ACTION=`zenity --width=250 --height=300 --list --radiolist --text="Select logout action" --title="Logout"  \
  --column "Choice" --column "Action" \
  TRUE Shutdown \
  FALSE Reboot \
  FALSE 'Lock Screen' \
  FALSE 'Log Out' \
  FALSE Suspend \
  `

brightnessctl --save

if [ -n "${ACTION}" ];then
  case $ACTION in
  Shutdown)
    zenity --question --no-wrap --text "Are you sure you want to halt?" && systemctl poweroff
    ;;
  Reboot)
    zenity --question --no-wrap --text "Are you sure you want to reboot?" && systemctl reboot
    ;;
  Suspend)
    lock && systemctl suspend
    ;;
  'Log Out')
    i3-msg exit
    ;;
  'Lock Screen')
    lock
    ;;
  esac
fi
