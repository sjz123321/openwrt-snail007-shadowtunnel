# openwrt-snail007-shadowtunnel

openwrt package for snail007-shadowtunnel

感谢snail007提供的帮助，谢谢老大

**[English](/README.md)**

## version

v1.0

程序发布

## Features

一个安全的隧道协议保护您和服务器之间的tcp通信

一个可以用于openwrt的轻量级代理软件

在你的路由器上实现透明代理

可选的密码加密

可选择tcp over udp功能使用

## 界面截图
![1.1](/pic/main_cn.jpg)

## 面向开发者

### 编译

首先你需要安装openwrt编译环境在你的linux上或者你应该有一个和你的路由架构对应的openwrt SDK

See https://openwrt.org/docs/guide-developer/source-code/start 

然后你需要在openwrt根目录下运行

`./scripts/feeds update`

`./scripts/feeds install -a`

好了，现在feeds已经更新了，准备进行下一步操作

`cd /package`

`git clone https://github.com/sjz123321/openwrt-snail007-shadowtunnel.git`

`cd ../`

`make menuconfig`

等一会儿你就能看到 menuconfig了

选择 luci-->collections-->luci

选择 luci-->Applications-->luci-app-shadowtunnel

取消选择 Base system-->dnsmasq 重要!! 否则一定会编译失败!

exit&save

`make V=99`

完成了！

### 编译设置截图
![1.2](/pic/after_git.png) 
![1.3](/pic/luci_app.png) 
![1.4](/pic/luci_app_in.png) 
![1.5](/pic/dnsmasq.png) 
