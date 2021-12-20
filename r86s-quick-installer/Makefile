include $(TOPDIR)/rules.mk

PKG_NAME:=r86s-quick-installer
PKG_VERSION:=1
PKG_RELEASE:=1

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

define Build/Configure
endef

define Package/r86s-quick-installer/install
        $(INSTALL_DIR) $(1)/root/
        $(INSTALL_BIN) $(PKG_BUILD_DIR)/src/clean-emmc.sh $(1)/root/
endef

$(eval $(call BuildPackage,r86s-quick-installer))