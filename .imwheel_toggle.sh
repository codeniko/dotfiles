#! /bin/bash

ps -ef | grep -E 'imwheel.+4 5$' > /dev/null
if [ $? -eq 0 ]; then
    killall imwheel
    zenity --notification --text='Optimized touchpad'
else
    imwheel -kill -b "4 5"
    zenity --notification --text='Optimized mouse'
fi

