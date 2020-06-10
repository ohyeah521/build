#!/bin/bash

export KERNEL_DEFCONFIG=$1
export RELEASE_NUMBER=$2

if [ ! $KERNEL_DEFCONFIG ]; then
    export KERNEL_DEFCONFIG="rockchip_linux_defconfig"
fi

if [ ! $RELEASE_NUMBER ]; then
    export RELEASE_NUMBER="1"
fi

CMD=`realpath $0`
BUILD_DIR=`dirname $CMD`
ROCKCHIP_BSP_DIR=$(realpath $BUILD_DIR/..)
ROCKDEV_DIR=$ROCKCHIP_BSP_DIR/rockdev
[ ! -d "$ROCKDEV_DIR" ] && mkdir $ROCKDEV_DIR
KERNEL_DIR=$ROCKCHIP_BSP_DIR/kernel

echo -e "\e[31m Start to pack kernel. \e[0m"
cd ${KERNEL_DIR} && make distclean && make -f $ROCKCHIP_BSP_DIR/build/kernel-package.mk kernel-package

mv $ROCKCHIP_BSP_DIR/linux-*${RELEASE_NUMBER}-rockchip*.deb $ROCKDEV_DIR
echo -e "\e[31m Packing kernel is done. \e[0m"
