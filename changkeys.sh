#!/bin/bash
# 这个脚本用于对调左Ctrl键为CapsLocK键，并实现打开和关闭该功能
#脚本使用环境是X11环境，需要用的X下的xmodmap 和notify-send
#首次使用脚本会自动在当前用户目录下建立名为.caps2ctrl的文件

#local_key_caps=$(xmodmap -pke|grep -m1 "Caps"|tr -cd [:digit:])
#local_key_ctrl_l=$(xmodmap -pke|grep -m1 "Control_L"|tr -cd [:digit:])
if [ ! -f ~/.caps2ctrl ];then
    echo -e  "!
! Swap Caps_Lock and Control_L
!
remove Lock = Caps_Lock
remove Control = Control_L
keysym Control_L = Caps_Lock
keysym Caps_Lock = Control_L
add Lock = Caps_Lock
add Control = Control_L" > ~/.caps2ctrl
fi

#keynum=$(xmodmap -pke|grep -m1 "Caps"|tr -cd [:digit:])
#echo $keynum
xmodmap ~/.caps2ctrl
if [ $? == 0 ];then
    echo "Change Caps to Ctrl sucess!"
    notify-send --expire-time=100 "Change Caps to Ctrl sucess!"
else
    echo "Change Caps to Ctrl fail!"
    notify-send --expire-time=100 "Change Caps to Ctrl fail!"
fi