#!/bin/sh
hour=`uci get /etc/config/shadowtunnel.@login[0].hour`
case $hour in
24)
	##crontab -r
    ;;
*)
	##crontab -r
	mkdir /tmp/crond/
	echo "0 $hour * * * sh /etc/shadowtunnel/update_chn_ipaddr.sh && sleep 30" >> /tmp/crond/root_update
	crontab /tmp/crond/root_update
	rm -f /tmp/crond/root_update
;;
esac
exit 0
