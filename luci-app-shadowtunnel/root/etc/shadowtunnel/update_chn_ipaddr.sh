#!/bin/sh
chnroute_tmp_path="/tmp/chnroute.txt"
chnroute_path="/etc/chnroute.txt"
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > $chnroute_tmp_path

if [ $(ls -l $chnroute_tmp_path | awk '{ print $5 }') -gt 10000 ] ; then
    mv $chnroute_tmp_path $chnroute_path
    echo  "$chnroute_path updated."
fi

rm -rf $chnroute_tmp_path

i=`cat /etc/chnroute.txt | wc -l`
until [ $i -le 0 ]
do
ip=`sed -n "$i p " /etc/chnroute.txt`
ipset add ipchn $ip
let "i-=1"
done
cp ipset_bak.db ipset_bak.db.old
ipset save ipchn /etc/ipset_bak.db
echo "GFW ipset update compelete"
exit 0

