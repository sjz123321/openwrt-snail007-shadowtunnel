require("luci.sys")

m=Map("shadowtunnel",translate("Shadowtunnel tproxy"),translate("a tiny tproxy software"))

s=m:section(TypedSection,"login","")
s.addremove=false
s.anonymous=true

switch=s:option(ListValue,"switch",translate("switch"))
switch:value("enable",translate("enable"))
switch:value("disable",translate("disable"))

udp=s:option(ListValue,"udp",translate("transport protocol"))
udp:value("normal",translate("tcp mode"))
udp:value("udp",translate("udp over tcp mode"))

ipaddr=s:option(Value,"ipaddr",translate("server ip address"))
ipaddr.datatype = "ip4addr"
ipaddr.rmempty = false


port=s:option(Value,"port",translate("server port"))
port.datatype = "range(1,65535)"
port.rmempty = false

localport=s:option(Value,"localport",translate("local port"))
localport.datatype = "range(1,65535)"
localport.rmempty = false

pwenable=s:option(ListValue,"pwenable",translate("password mode"))
pwenable:value("enable",translate("manual"))
pwenable:value("disable",translate("default"))

passwd=s:option(Value,"passwd",translate("password"))
passwd.datatype = "host"
passwd.rmempty = true

local e=luci.http.formvalue("cbi.apply")
if e then
  os.execute("chmod +x /etc/init.d/control_shadowt")
  os.execute("chmod +x /etc/ipt.sh")
  io.popen("/etc/init.d/control_shadowt restart")
end

return m
