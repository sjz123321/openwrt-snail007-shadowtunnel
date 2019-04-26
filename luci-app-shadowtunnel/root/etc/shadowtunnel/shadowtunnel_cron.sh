#!/bin/sh
sleep 5
switch=`uci get /etc/config/shadowtunnel.@login[0].switch`
case $switch in
enable)
	;;
disable)
	exit 0
	;;
esac
reset=`uci get /etc/config/shadowtunnel.@login[0].reset`
case $reset in
0)
	crontab -r
    ;;
*)
	crontab -r
	mkdir /tmp/crond/
	echo "* */$reset * * * sh /etc/shadowtunnel/shadowtunnel_restart.sh && sleep 30" >> /tmp/crond/root
	;;
esac
hour=`uci get /etc/config/shadowtunnel.@login[0].hour`

case `echo $hour | wc -w` in
0)
	exit 0
	;;
*)
	;;
esac

case $hour in
24)
	crontab -r
    ;;
*)
	crontab -r
	mkdir /tmp/crond/
	echo "0 $hour 15 * * sh /etc/shadowtunnel/update_chn_ipaddr.sh && sleep 30" >> /tmp/crond/root
	crontab /tmp/crond/root
	rm -f /tmp/crond/root
	;;
esac
exit 0
