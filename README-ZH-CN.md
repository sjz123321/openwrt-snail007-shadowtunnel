# openwrt-snail007-shadowtunnel

openwrt package for snail007-shadowtunnel

感谢snail007提供的帮助

**[English](/README.md)**

## version

v1.0

程序发布

v2.0

重构了整个程序

增加了更多新功能（见Features)

## Features

v1.0

### 一个安全的隧道协议保护您和服务器之间的tcp通信

### 一个可以用于openwrt的轻量级代理软件

### 在你的路由器上实现透明代理

### 可选的密码加密

### 可选择tcp over udp功能使用

v2.0

### DNS防污染(新):

#### Shadowtunnel 提供了两种DNS防污染功能：

#### 当你运行在全局代理模式时，可以选择DNS 防污染！

#### 你可以单独运行DNS代理，来代理你的DNS请求。

### 自定义hosts(新):

#### 现在可以使用类似于windows hosts 文件的格式自定义hosts。

### 更多的代理模式(新):

#### 现在shadowtunnel提供四种可选择的代理模式：

#### 全局代理模式

#### 仅代理DNS模式

#### 绕过中国区IP模式(中国域名不走代理，国外域名走代理)

#### 仅代理中国IP模式(回国模式，可在国外看腾讯视频爱奇艺等！)


## 安装教程

### 如何判断路由器cpu架构?

首先用串口或者ssh连接到路由器

运行 `opkg update` 之后你会看到cpu的架构如下图所示
![1.6](/pic/cpu_arch.png)

### 如何安装程序包?

下载 shadowtunnel + luci-app- luci-i18n-

将程序包上传到路由器中

进入程序包放置的目录运行如下代码

`opkg install shadowtunnel_*.ipk`

`opkg install luci-app-shadowtunnel*`

刷新路由管理页面

现在你可以在 服务-->shadowtunnel 中找到他了

Thanks && enjoy!

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
