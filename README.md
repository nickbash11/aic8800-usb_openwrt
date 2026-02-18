# Tenda AIC8800 Linux Driver for OpenWrt (24.10.x)

## Description
This repository contains the modified Tenda AIC8800 USB WiFi driver to support OpenWrt (24.10.x)

## Features
- Support for Tenda AX300 USB WiFi adapter
- Compatible with Linux kernel 6.6.x
- Modified from official Tenda Debian package

## Requirements
- Linux
- Tenda AX300 USB WiFi adapter
- Openwrt SDK/Sources

## Installation
```bash
# Download SDK (sunxi is just an example!)
wget https://downloads.openwrt.org/releases/24.10.5/targets/sunxi/cortexa7/openwrt-sdk-24.10.5-sunxi-cortexa7_gcc-13.3.0_musl_eabi.Linux-x86_64.tar.zst
# Unpack SDK
tar --zstd -xvf openwrt-sdk-24.10.5-sunxi-cortexa7_gcc-13.3.0_musl_eabi.Linux-x86_64.tar.zst
# Go to SDK
cd openwrt-sdk-24.10.5-sunxi-cortexa7_gcc-13.3.0_musl_eabi.Linux-x86_64
# Update and install all packages
./scripts/feeds update -a
./scripts/feeds install -a
# Clone the repository
git clone https://github.com/nickbash11/aic8800-usb_openwrt package/kernel/aic8800-usb
# Build
make package/aic8800-usb/compile V=s -j$(nproc)
```

## Package
After building you can find the package in your target destination:
```bash
ls -alh bin/targets/sunxi/cortexa7/packages/kmod-aic8800-usb_6.6.110.1.0-r1_arm_cortex-a7_neon-vfpv4.ipk
```

## Troubleshooting
If you encounter any issues:
1. Check if the device is recognized: `lsusb`
2. Verify driver loading: `dmesg | grep aic8800`
3. Check WiFi interface: `iwconfig` or `iw dev`


## Disclaimer
This is an unofficial modification of Tenda's driver. Use at your own risk. 
