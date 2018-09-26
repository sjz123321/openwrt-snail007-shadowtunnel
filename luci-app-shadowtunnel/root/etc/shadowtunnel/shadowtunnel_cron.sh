#!/bin/sh
case $1 in
0)
    ;;
*)
    case $2 in
        start)
            mkdir -p /tmp/crond
            touch /etc/crontabs/root
            cp /etc/crontabs/root /tmp/crond
            count=`grep "res_sha.sh" chnroute.txt.old -n`
            num=${count%:*}
            sed -i "$num"d /tmp/crond
            echo "* */$1 * * * sh /etc/shadowtunnel/res_sha.sh && sleep 30" >> /tmp/crond/root
            crontab /tmp/crond/root
            rm -f /tmp/crond

            ;;

        stop)
            count=`grep "res_sha.sh" chnroute.txt.old -n`
            num=${count%:*}
            sed -i "$num"d /tmp/crond
            crontab /tmp/crond/root
            rm -f /tmp/crond

            ;;

    esac
esac
