module("luci.controller.shadowtunnel",package.seeall)
function index()
entry({"admin","services","shadowtunnel"},cbi("shadowtunnel"),_("shadowtunnel"))
end
