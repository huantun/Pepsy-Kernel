#!/bin/bash

KERNEL_DIR=$PWD
ANYKERNEL_DIR=$KERNEL_DIR/AnyKernel2-AIO
DTBTOOL=$KERNEL_DIR/dtbTool
CCACHEDIR=../CCACHE
TOOLCHAINDIR=~/toolchain/aarch64-linux-android-4.9
DATE=$(date +"%d%m%Y")
KERNEL_NAME="Pepsy-Kernel"
DEVICE="-Xiaomi-MSM8996-"
VER="-v0.1"
TYPE="-O-MR1"
FINAL_ZIP="$KERNEL_NAME""$DEVICE""$DATE""$TYPE""$VER".zip

rm $ANYKERNEL_DIR/*/zImage $ANYKERNEL_DIR/*/dtb $ANYKERNEL_DIR/*/*.zip
rm $KERNEL_DIR/arch/arm64/boot/Image.gz $KERNEL_DIR/arch/arm64/boot/dt.img $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb

export ARCH=arm64
export KBUILD_BUILD_USER="Psy_Man"
export KBUILD_BUILD_HOST="PsyBuntu"
export CROSS_COMPILE=$TOOLCHAINDIR/bin/aarch64-linux-android-
export LD_LIBRARY_PATH=$TOOLCHAINDIR/lib/
export USE_CCACHE=1

export CCACHE_DIR=$CCACHEDIR/gemini/.ccache
make clean && make mrproper
make gemini_defconfig
make -j$( nproc --all )

./dtbTool -s 2048 -o arch/arm64/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/qcom/
mv $KERNEL_DIR/arch/arm64/boot/dt.img $ANYKERNEL_DIR/gemini/dtb
mv $KERNEL_DIR/arch/arm64/boot/Image.gz $ANYKERNEL_DIR/gemini/zImage

export CCACHE_DIR=$CCACHEDIR/capricorn/.ccache
make clean && make mrproper
make capricorn_defconfig
make -j$( nproc --all )

./dtbTool -s 2048 -o arch/arm64/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/qcom/
mv $KERNEL_DIR/arch/arm64/boot/dt.img $ANYKERNEL_DIR/capricorn/dtb
mv $KERNEL_DIR/arch/arm64/boot/Image.gz $ANYKERNEL_DIR/capricorn/zImage

export CCACHE_DIR=$CCACHEDIR/natrium/.ccache
make clean && make mrproper
make natrium_defconfig
make -j$( nproc --all )

./dtbTool -s 2048 -o arch/arm64/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/qcom/
mv $KERNEL_DIR/arch/arm64/boot/dt.img $ANYKERNEL_DIR/natrium/dtb
mv $KERNEL_DIR/arch/arm64/boot/Image.gz $ANYKERNEL_DIR/natrium/zImage

export CCACHE_DIR=$CCACHEDIR/lithium/.ccache
make clean && make mrproper
make lithium_defconfig
make -j$( nproc --all )

./dtbTool -s 2048 -o arch/arm64/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/qcom/
mv $KERNEL_DIR/arch/arm64/boot/dt.img $ANYKERNEL_DIR/lithium/dtb
mv $KERNEL_DIR/arch/arm64/boot/Image.gz $ANYKERNEL_DIR/lithium/zImage

export CCACHE_DIR=$CCACHEDIR/scorpio/.ccache
make clean && make mrproper
make scorpio_defconfig
make -j$( nproc --all )

./dtbTool -s 2048 -o arch/arm64/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/qcom/
mv $KERNEL_DIR/arch/arm64/boot/dt.img $ANYKERNEL_DIR/scorpio/dtb
mv $KERNEL_DIR/arch/arm64/boot/Image.gz $ANYKERNEL_DIR/scorpio/zImage

cd $ANYKERNEL_DIR
zip -r9 $FINAL_ZIP * -x *placeholder
