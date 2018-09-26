#!/bin/sh

add_serveripaddr()
{
	line=`cat /tmp/raw_ip.temp | wc -l`
	until [ $line -le 0 ] 
	do
		ip=`sed -n "$line p " /tmp/raw_ip.temp`
		iptables -t nat -A PROXY -d ${ip%%:*} -j RETURN
		let "line-=1"
	done
	
}

if [ $1 == "-h" ] ; then
	echo "invald parameter"
	echo "usage: ipt.sh [server_ipaddr] [local_port]"
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

add_serveripaddr

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

add_serveripaddr

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


