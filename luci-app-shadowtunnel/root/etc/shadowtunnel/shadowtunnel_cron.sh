#!/bin/sh
hour=`uci get /etc/config/shadowtunnel.@login[0].hour`
case $hour in
0)
	crontab -r
    ;;
*)
	crontab -r
	mkdir /tmp/crond/
	echo "* */$hour * * * sh /etc/shadowtunnel/shadowtunnel_restart.sh && sleep 30" >> /tmp/crond/root
	crontab /tmp/crond/root
	rm -f /tmp/crond/root
;;
esac
exit 0
