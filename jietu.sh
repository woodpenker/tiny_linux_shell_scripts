#!/bin/bash
#这是截图脚本 wudy 2016-05-29
#截图存放位置:修改此处即可,默认~/
picloc="~/"

export DISPLAY=:0.0
if [ -d $picloc ] && [ -w $picloc ];then  
gnome-screenshot -a -f $picloc/$(date +%Y%m%d_%H%M%S).png
notify-send --expire-time=200 "截图已经保存到$picloc"
else 
notify-send --expire-time=200 "截图出现问题，保存位置$picloc不存在或者目录不可被写入！"
fi
