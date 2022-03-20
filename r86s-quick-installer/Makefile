include $(TOPDIR)/rules.mk

PKG_NAME:=r86s-quick-installer
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
PKG_CONFIG_DEPENDS := 

include $(INCLUDE_DIR)/package.mk

define Package/r86s-quick-installer
	SECTION:=base
	CATEGORY:=Network
	DEFAULT:=y
	TITLE:=R86S Quick System Installer
	URL:=https://github.com/R86S/R86S-QuickInstaller
endef

define Package/r86s-quick-installer/description
 A System Installer for R86S MINIPC
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)
	chmod +x $(PKG_BUILD_DIR)/*.sh
endef

define Build/Compile
endef 

define Package/r86s-quick-installer/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-clean-emmc.sh $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-decrypt-info.sh $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-install-os-online.sh $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-write-this-to-emmc.sh $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-nic-test-server.sh $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-10g-test.sh $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-2.5g-test.sh $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/r86s-channel-publickey.pem $(1)/etc/
endef

$(eval $(call BuildPackage,r86s-quick-installer))
