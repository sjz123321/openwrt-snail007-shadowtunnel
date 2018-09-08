# openwrt-snail007-shadowtunnel

openwrt package for snail007-shadowtunnel

Thanks for snail007's help @snail007

**[中文](/README-ZH-CN.md)**

## version

v1.0

Program release

## Features

Secure tunnel which help you protecting your tcp traffic between your machine and your service on remote.

A tiny proxy software that can be used on openwrt platform

Tproxy mode on the router

optional password to encrypt the connection between client & server

tcp over udp function makes proxy more flexible

## Screenshot
![1.1](/pic/main_en.jpg)

## For developer

### compile

Firstly you should build openwrt compiling environment or have a openwrt SDK based on your platform.

See https://openwrt.org/docs/guide-developer/source-code/start 

After that running following command on the openwrt root directory

`./scripts/feeds update`

`./scripts/feeds install -a`

Ok,now we have updated feeds package for openwrt compiling system

`cd /package`

`git clone https://github.com/sjz123321/openwrt-snail007-shadowtunnel.git`

`cd ../`

`make menuconfig`

after a while you can see the menuconfig`

choose luci-->collections-->luci

choose luci-->Applications-->luci-app-shadowtunnel

unchoose Base system-->dnsmasq important!! if not the compile will be fail!

exit&save

`make V=99`

enjoy!

### compile setting screenshot
![1.2](/pic/after_git.png) 
![1.3](/pic/luci_app.png) 
![1.4](/pic/luci_app_in.png) 
![1.5](/pic/dnsmasq.png) 
