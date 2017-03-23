#!/bin/bash
#这是截图脚本 wudy 2016-05-29
export DISPLAY=:0.0
if [ -d /media/d/资料文档/截图/ ] && [ -w /media/d/资料文档/截图/ ];then  
gnome-screenshot -a -f /media/d/资料文档/截图/$(date +%Y%m%d_%H%M%S).png
notify-send --expire-time=200 "截图已经保存到/media/d/资料文档/截图/"
else 
notify-send --expire-time=200 "截图出现问题，保存位置不存在或者目录不可被写入！"
fi
