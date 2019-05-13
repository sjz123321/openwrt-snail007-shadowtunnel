# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowtunnel
PKG_VERSION:=v1.7
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

ifeq ($(ARCH),x86_64) 
	PKG_ARCH_PROXY:=linux-amd64
endif 
ifeq ($(ARCH),mipsel) 
	PKG_ARCH_PROXY:=linux-mipsle
endif 
ifeq ($(ARCH),mips) 
	PKG_ARCH_PROXY:=linux-mips
endif 
ifeq ($(ARCH),i386) 
	PKG_ARCH_PROXY:=linux-386
endif 
ifeq ($(ARCH),arm) 
	PKG_ARCH_PROXY:=linux-arm
endif 
ifeq ($(ARCH),aarch64) 
	PKG_ARCH_PROXY:=linux-arm64
endif

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=shadowtunnel is a tiny proxy software ^v^
	DEPENDS:=
	URL:=https://github.com/snail007/shadowtunnel/
endef

define Package/$(PKG_NAME)/config
endef

define Package/$(PKG_NAME)/description
shadowtunnel is a tiny proxy software ^v^
endef

define Build/Prepare
	
	wget -P $(PKG_BUILD_DIR)/shadowtunnel-$(PKG_VERSION)/$(PKG_VERSION)/  https://github.com/snail007/shadowtunnel/releases/download/$(PKG_VERSION)/shadowtunnel-$(PKG_ARCH_PROXY).tar.gz
	tar -xzvf $(PKG_BUILD_DIR)/shadowtunnel-$(PKG_VERSION)/$(PKG_VERSION)/shadowtunnel-$(PKG_ARCH_PROXY).tar.gz -C $(PKG_BUILD_DIR) 
	
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install 
	$(INSTALL_DIR) $(1)/usr/bin/shadowtunnel/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/shadowtunnel $(1)/usr/bin/shadowtunnel/
endef 

$(eval $(call BuildPackage,$(PKG_NAME)))
