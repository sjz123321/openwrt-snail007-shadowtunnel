require("luci.sys")

m=Map("shadowtunnel",translate("Shadowtunnel tproxy"),translate("a tiny tproxy software"))

s=m:section(TypedSection,"login","")
s.addremove=false
s.anonymous=true

switch=s:option(ListValue,"switch",translate("switch"))
switch:value("enable",translate("enable"))
switch:value("disable",translate("disable"))

mode=s:option(ListValue,"mode",translate("Proxy mode selection"))
mode:value("CHN_ONLY",translate("Proxy Chinese IP Only"))
mode:value("Global",translate("Global mode"))
mode:value("DNS",translate("DNS mode"))
mode:value("GFW",translate("Bypassing the Chinese mainland's ip mode"))

ipaddr=s:option(DynamicList,"ipaddr",translate("server ip address"))
ipaddr.description = translate("Note: Please enter the server's password@ip:port#weight like example. Example st@11.22.33.44:5566#1 Both @.. and #.. is optional. a. Using weight balance-strategy ...#(your_setting_weight). b. Setting unique password for this server (your_passwd)@... ps. -p password is a global password. if you are not setting unique password for the server")


encrypt=s:option(ListValue,"encrypt",translate("encrypt method"))
encrypt:value("aes-192-cfb",translate("aes-192-cfb(default)"))
encrypt:value("aes-128-ctr")
encrypt:value("aes-256-ctr")
encrypt:value("bf-cfb")
encrypt:value("rc4-md5-6")
encrypt:value("chacha20-ietf")
encrypt:value("aes-128-cfb")
encrypt:value("aes-256-cfb")
encrypt:value("aes-192-ctr")
encrypt:value("des-cfb")
encrypt:value("cast5-cfb")
encrypt:value("rc4-md5")
encrypt:value("chacha20")

passwd=s:option(Value,"passwd",translate("Global Password"))
passwd.datatype = "host"
passwd.rmempty = true


udp=s:option(ListValue,"udp",translate("transport protocol"))
udp:value("normal",translate("tcp mode"))
udp:value("udp",translate("tcp over udp mode"))
udp.description = translate("Note: To save memory , compression is off")

dns_enable=s:option(ListValue,"dns_enable",translate("prevent DNS pollution"))
dns_enable:value("1",translate("enable"))
dns_enable:value("0",translate("disable"))
dns_enable:depends({mode="GFW"})
dns_enable:depends({mode="Global"})

strategy=s:option(ListValue,"strategy",translate("balance strategy"))
strategy:value("roundrobin",translate("roundrobin"))
strategy:value("leastconn",translate("leastconn"))
strategy:value("leasttime",translate("leasttime"))
strategy:value("hash",translate("hash"))
strategy:value("weight",translate("weight"))

hour=s:option(Value,"hour",translate("select a time to update CHN-IPs list everyday"))
hour:value("0")
hour:value("1")
hour:value("2")
hour:value("3")
hour:value("4")
hour:value("5")
hour:value("6")
hour:value("7")
hour:value("8")
hour:value("9")
hour:value("10")
hour:value("11")
hour:value("12")
hour:value("13")
hour:value("14")
hour:value("15")
hour:value("16")
hour:value("17")
hour:value("18")
hour:value("19")
hour:value("20")
hour:value("21")
hour:value("22")
hour:value("23")
hour:value("24",translate("disable"))
hour.description = translate("Note:To ensure GFW is up to date GFW-List will be update every month.but it may cost a long time so it is recommanded to update when you are not using router.")
hour:depends({mode="GFW"})
hour:depends({mode="Global"})
hour:depends({mode="CHN_ONLY"})


reset=s:option(ListValue,"reset",translate("Automaticly restart shadowtunnel"))
reset:value("0",translate("disable"))
reset:value("3",translate("3 hours"))
reset:value("6",translate("6 hours"))
reset:value("12",translate("12 hours"))
reset:value("24",translate("24 hours"))
reset.description = translate("To ensure the stable operation of shadowtunnel,you can set the timer to restart it automaticly")

extra=s:option(DynamicList,"extra",translate("IP list without proxy"))
extra.rmempty = true
extra.description = translate("<br/>Add the IP list with directly connected to the list, one per line, in the format 1.2.3.4. You can use the cidr format such as 10.0.0.0/8.")

hosts=s:option(TextValue,"hosts",translate("Custom hosts setting"))
hosts.rmempty = true   
hosts.rows = 10 
hosts.description = translate("<br/>Note: Shadowtunnel provides custom hosts in the same format as the hosts file,which you can customize as needed")
hosts:depends({mode="DNS"})                                                                           
hosts:depends({dns_enable="1"})

dns_forward=s:option(TextValue,"dns_forward",translate("Custom Dns forward setting"))
dns_forward.rmempty = true   
dns_forward.rows = 10 
dns_forward:depends({mode="DNS"})                                                                     
dns_forward:depends({dns_enable="1"})

local e=luci.http.formvalue("cbi.apply")
if e then
  io.popen("/etc/init.d/control_shadowt restart &")
  os.execute("crontab -r")
  --if (switch==enable) then
  os.execute("sh /etc/shadowtunnel/shadowtunnel_cron.sh &")
  --end
  --os.execute("sh /etc/shadowtunnel/ipset_cron.sh")
end

return m
