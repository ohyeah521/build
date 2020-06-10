#!/bin/bash

export TARGET_BOARD=$1
if [ ! $TARGET_BOARD ];then
    exit
fi

CMD=`realpath $0`
BUILD_DIR=`dirname $CMD`
ROCKCHIP_BSP_DIR=$(realpath $BUILD_DIR/..)
ROCKDEV_DIR=$ROCKCHIP_BSP_DIR/rockdev
[ ! -d "$ROCKDEV_DIR" ] && mkdir $ROCKDEV_DIR
UBOOT_DIR=$ROCKCHIP_BSP_DIR/u-boot

cd $UBOOT_DIR
make ubootrelease > ./ubootrelease.tmp
sed -i 's/"//g' ./ubootrelease.tmp
export LATEST_UBOOT_VERSION=$(cat ./ubootrelease.tmp)
echo "LATEST_UBOOT_VERSION = $LATEST_UBOOT_VERSION"
export RELEASE_VERSION=$LATEST_UBOOT_VERSION
rm ./ubootrelease.tmp

cd ${ROCKDEV_DIR} && make -f ${BUILD_DIR}/uboot-package.mk rk-ubootimg-package
