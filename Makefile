include $(TOPDIR)/rules.mk

PKG_NAME:=kmod-aic8800-usb-shenmintao
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shenmintao/aic8800dc.git
PKG_SOURCE_VERSION:=345197236448de0369bdec93986b5718a6f04529 

PKG_MIRROR_HASH:=

PKG_MAINTAINER:=NickBash11 <nybash110998@gmail.com>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/aic8800-usb-shenmintao
	SUBMENU:=Wireless Drivers
	TITLE:=AIC8800 USB WiFi Driver (Tenda/Friddle)
	DEPENDS:=+kmod-cfg80211 +kmod-mac80211 +kmod-usb-core +kmod-usb2
	FILES:= \
		$(PKG_BUILD_DIR)/drivers/aic8800/aic8800_fdrv/aic8800_fdrv.ko \
		$(PKG_BUILD_DIR)/drivers/aic8800/aic_load_fw/aic_load_fw.ko
	AUTOLOAD:=$(call AutoLoad,50,aic_load_fw aic8800_fdrv)
endef

define KernelPackage/aic8800-usb-shenmintao/description
	Driver for AIC8800 USB WiFi (Tenda AX300 etc.)
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Compile
	+$(KERNEL_MAKE) $(PKG_JOBS) \
		$(KERNEL_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)/drivers/aic8800/" \
		KBUILD_EXTRA_SYMBOLS="$(LINUX_DIR)/../symvers/mac80211.symvers" \
		CFLAGS_MODULE="-g" \
		modules
endef

define KernelPackage/aic8800-usb-shenmintao/install
	$(INSTALL_DIR) $(1)/lib/firmware/aic8800DC
	$(CP) $(PKG_BUILD_DIR)/fw/aic8800DC/*.bin $(1)/lib/firmware/aic8800DC/
endef

$(eval $(call KernelPackage,aic8800-usb-shenmintao))
