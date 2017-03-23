#!/bin/bash
# date 2016-05-12 auth wudy
# this is a shell for showing logined time to have a rest
# Usage:add "uptime | cut -d " " -f2 >$DIR/starttime.dat" to your rc.local file in /etc


###############
if [ ! -e ./starttime.dat ];then
touch ./starttime.dat
uptime | cut -d " " -f2 >./starttime.dat
fi
if [ ! -e ./notify.log ];then
touch ./notify.log
fi
get_hour=$(uptime | cut -d ',' -f1 |cut -d ' ' -f2 |cut -d ':' -f1|sed 's/^0//g')
get_min=$(uptime | cut -d ',' -f1 |cut -d ' ' -f2 |cut -d ':' -f2|sed 's/^0//g')
#get_sec=$(uptime | cut -d ',' -f1 |cut -d ' ' -f2 |cut -d ':' -f3)
start_hour=$(cat ./starttime.dat | cut -d ':' -f1|sed 's/^0//g')
start_min=$(cat ./starttime.dat | cut -d ':' -f2|sed 's/^0//g')
#start_sec=$(cat starttime.dat | cut -d ':' -f3)
notify_flag=0
if [ $get_hour -gt $start_hour ]; then
	hour_past=$(($get_hour-$start_hour))
	min_past=$(($hour_past*60+$get_min-$start_min))
	if [ $min_past -ge 60 ]; then 
		notify_flag=1
	fi
fi		
if [ $notify_flag -eq 1 ]; then 
	export DISPLAY=:0.0
	notify-send -t 5000 "已经１小时了，该休息一下了！"
	uptime | cut -d ',' -f1 |cut -d ' ' -f2 >./starttime.dat
	echo "$get_hour:$get_min $start_hour:$start_min $min_past $notify_flag  success">>notify.log
	zenity --warning --text "已经１小时了，该休息一下了！"
else 
	echo "0"	
	#echo "$get_hour:$get_min $start_hour:$start_min none  $notify_flag ">>notify.log
fi
unset get_hour
unset get_min
unset start_hour
unset start_min
unset notify_flag
unset hour_past
unset min_past

