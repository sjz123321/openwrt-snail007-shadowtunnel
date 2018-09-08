if [ $1 == "-h" ] ; then
	echo "invald parameter"
	echo "usage: ipt.sh [server_ipaddr] [local_port]"
fi
proxy_server_ip=$1

#路由器运行proxy监听的端口:
proxy_local_port=$2


case $3 in
start)

#下面的就不用修改了
#create a new chain named PROXY
iptables -t nat -N PROXY

# Ignore your PROXY server's addresses
# It's very IMPORTANT, just be careful.

iptables -t nat -A PROXY -d $proxy_server_ip -j RETURN

# Ignore LANs IP address
iptables -t nat -A PROXY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A PROXY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A PROXY -d 240.0.0.0/4 -j RETURN

# Anything to port 80 443 should be redirected to PROXY's local port
iptables -t nat -A PROXY -p tcp --dport 80 -j REDIRECT --to-ports $proxy_local_port
iptables -t nat -A PROXY -p tcp --dport 443 -j REDIRECT --to-ports $proxy_local_port

# Apply the rules to nat client
iptables -t nat -A PREROUTING -p tcp -j PROXY
# Apply the rules to localhost
iptables -t nat -A OUTPUT -p tcp -j PROXY

;;

stop)
iptables -t nat -F PROXY

;;

esac

