#!/bin/sh
case $1 in
start)
	start_ipset
	
	;;

stop)
	stop_ipset
	;;

restart)
	stop_ipset
	start_ipset
	
	;;

esac

start_ipset()
{
	i=`cat /etc/chnroute.txt | wc -l`
	until [ $i -le 0 ]
	do
		ip=`sed -n "$i p" /etc/chnroute.txt`
		ipset add ipchn $ip
		let "i-=1"
	done
	
}

stop_ipset()
{

}

