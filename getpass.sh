#!/bin/bash
#sleep 0.5

#XCLIP=$(which xclip)
#if [ "$XCLIP" == "" ]; then
#    echo "Need to install xclip"
#    exit 1
#fi

XDOTOOL=$(which xdotool)
if [ "$XDOTOOL" == "" ]; then
    echo "Need to install xdotool"
    exit 1
fi
WINDOW_NAME=$($XDOTOOL getactivewindow getwindowname)
#WINDOW_ID=$($XDOTOOL getwindowfocus)
ACTIVEWIN=$($XDOTOOL getactivewindow)
if [ "$ACTIVEWIN" == "" ]; then
    exit;
fi

#TEXT=$($XCLIP -out)
TEXT=$(lpass show --password $1)

if [ "$TEXT" == "" ]; then
    zenity --info --text "I didn't get the password"
    exit;
fi

zenity --question --text "I've got the password and will past it into the window named:\n\n$WINDOW_NAME"
if [ $? -eq 1 ]; then
  exit;
fi

$XDOTOOL windowactivate --sync $ACTIVEWIN

if [ "$ACTIVEWIN" != "$($XDOTOOL getactivewindow)" ]; then
    zenity --info --text "Something stole focus!!";
    exit;
fi

$XDOTOOL type "$TEXT"
#$XDOTOOL key KP_Enter
