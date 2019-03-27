#!/bin/sh
add_serveripaddr()
{
        while :
        do
                num=`echo $1 | wc -w`
                case $num in
                0)
                        break
                        ;;
                *)
						temp=${1%%:*}
                        iptables -t nat -A PROXY -d ${temp##*@} -j RETURN
                        shift
                        ;;
                esac
        done
}
if [ $1 == "-h" ] ; then
	echo "invald parameter"
	echo "usage: ipt.sh [local_port] [run_mode]"
fi

#路由器运行proxy监听的端口:
proxy_local_port=$1


case $2 in
start)

#下面的就不用修改了
#create a new chain named PROXY
iptables -t nat -N PROXY

# Ignore your PROXY server's addresses
# It's very IMPORTANT, just be careful.

raw_ipaddr=`uci get /etc/config/shadowtunnel.@login[0].ipaddr | awk '{for(i=1;i<=NF;i++) printf $i" "}'`
raw_extra=`uci get /etc/config/shadowtunnel.@login[0].extra | awk '{for(i=1;i<=NF;i++) printf $i" "}'`
add_serveripaddr ${raw_ipaddr}
add_serveripaddr ${raw_extra}

# Ignore LANs IP address
iptables -t nat -A PROXY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A PROXY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A PROXY -d 240.0.0.0/4 -j RETURN

# Anyport tcp should be redirected to PROXY's local port
iptables -t nat -A PROXY -p tcp -j REDIRECT --to-ports $proxy_local_port

# Apply the rules to nat client
iptables -t nat -A PREROUTING -p tcp -j PROXY
# Apply the rules to localhost
iptables -t nat -A OUTPUT -p tcp -j PROXY

;;

stop)
iptables -t nat -X PROXY
iptables -t nat -F PROXY
ipset destroy ipchn

;;

GFW)
#下面的就不用修改了
#create a new chain named PROXY
iptables -t nat -N PROXY

# Ignore your PROXY server's addresses
# It's very IMPORTANT, just be careful.

raw_ipaddr=`uci get /etc/config/shadowtunnel.@login[0].ipaddr | awk '{for(i=1;i<=NF;i++) printf $i" "}'`
raw_extra=`uci get /etc/config/shadowtunnel.@login[0].extra | awk '{for(i=1;i<=NF;i++) printf $i" "}'`
add_serveripaddr ${raw_ipaddr}
add_serveripaddr ${raw_extra}

# Ignore LANs IP address
iptables -t nat -A PROXY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A PROXY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A PROXY -d 240.0.0.0/4 -j RETURN

# RETURN chinese address
ipset restore -f /etc/ipset_bak.db
iptables -t nat -A PROXY -m set --match-set ipchn dst -p tcp -j RETURN

# Anyport tcp should be redirected to PROXY's local port
iptables -t nat -A PROXY -p tcp -j REDIRECT --to-ports $proxy_local_port

# Apply the rules to nat client
iptables -t nat -A PREROUTING -p tcp -j PROXY
# Apply the rules to localhost
iptables -t nat -A OUTPUT -p tcp -j PROXY
 

esac


