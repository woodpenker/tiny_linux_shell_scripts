#!/bin/sh
##
##本脚本用于在实验室内开启ipv6功能，仅在中文环境下使用，请将本脚本加入到/etc/rc.local（ubuntu系统）的开机自动义启动项中
## 作者：wudy 最后修改时间：2017/3/6 
##如果是实验室网络地址则进行ipv6地址转换，如果不是实验室地址不开启此功能
#isLabEnv 用于判断是否实验室 havesit用于判断是否已经打开ipv6通道
#修改本脚本需要修改a b c d的参数
#########################################################################
isLabEnv=0 
havesit=0
#a是你本地的路由网关ipv4地址
    
#b是你本地的ipv4地址
   
#c是你本地网络的ipv6地址前96位 可在windows下查看
   
#d是你本地网络的ipv6默认网关地址 可在windows下查看
    
#echo "isLabEnv=$isLabEnv"
#获取当前有线网卡IP地址
ip=$(ifconfig enp3s0|grep "inet 地址"| sed 's/^.*地址://g' |sed 's/广播.*$//g')
#echo "ip=$ip"
#ip_begin 是当前网络地址的前缀，如果与实验室内网环境相同则设定参数islabenv为1
ip_begin=$(echo $ip | sed 's/\....$//g')
#echo "ip_begin=$ip_begin"
if [ "$ip_begin" = "192.168.106" ];then
	isLabEnv=1
fi
#echo "isLabEnv=$isLabEnv"
#sitstring是获取是否有sit存在，若不为空则说明已经打开过了，无需再打开
sitstring=$(ifconfig -a | grep sit)
if [ "$sitstring" = "" ];then 
	havesit=1
else
	echo "已经打开过ipv6通道了！"
fi
#echo "havesit=$havesit"

#当IP地址是实验室地址并且没有打开sit时，开启ipv6通道
if [ $isLabEnv -eq 1 ] && [ $havesit -eq 1 ];then 
	#a是你本地的路由网关ipv4地址
	a="192.168.0.1"  
	#b是你本地的ipv4地址
	b=$ip
	echo "b=$b"
	#如b不存在，无论如何都将b设置成一个固定的本地地址
	if [ "$b" = "" ];then
		b="本地ipv4地址"
	fi
	#c是你本地网络的ipv6地址前96位 可在windows下查看
	c="此处填入本地网络的ipv6地址前96位"
	#d是你本地网络的ipv6默认网关地址 可在windows下查看
	d="此处填入本地网络的ipv6默认网关地址"
	sudo modprobe ipv6
	sudo ip tunnel add sit1 mode sit ttl 128 remote $a local $b
	sudo ifconfig sit1 up
	sudo ifconfig sit1 add $c:$b
	sudo route -A inet6 add ::/0 gw $d sit1
	echo "ipv6 activatived"
	notify-send --expire-time=100 "ipv6 activatived！"
fi
#清除使用过的变量
unset a
unset b
unset c
unset d
unset isLabEnv
unset havesit
unset sitstring
unset ip_begin
unset ip
