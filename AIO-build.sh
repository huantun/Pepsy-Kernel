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
TYPE="-O-MR1-MIUI"
FINAL_ZIP="$KERNEL_NAME""$DEVICE""$DATE""$TYPE""$VER".zip

rm $ANYKERNEL_DIR/*/Image.gz-dtb $ANYKERNEL_DIR/*/*.zip $ANYKERNEL_DIR/modules/*.ko
rm $KERNEL_DIR/arch/arm64/boot/Image.gz $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb

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

mv $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb $ANYKERNEL_DIR/gemini

export CCACHE_DIR=$CCACHEDIR/capricorn/.ccache
make clean && make mrproper
make capricorn_defconfig
make -j$( nproc --all )

mv $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb $ANYKERNEL_DIR/capricorn

export CCACHE_DIR=$CCACHEDIR/natrium/.ccache
make clean && make mrproper
make natrium_defconfig
make -j$( nproc --all )

mv $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb $ANYKERNEL_DIR/natrium

export CCACHE_DIR=$CCACHEDIR/lithium/.ccache
make clean && make mrproper
make lithium_defconfig
make -j$( nproc --all )

mv $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb $ANYKERNEL_DIR/lithium

export CCACHE_DIR=$CCACHEDIR/scorpio/.ccache
make clean && make mrproper
make scorpio_defconfig
make -j$( nproc --all )

mv $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb $ANYKERNEL_DIR/scorpio

find $KERNEL_DIR -name '*.ko' -exec cp '{}' "$ANYKERNEL_DIR/modules" \;
cd $ANYKERNEL_DIR
zip -r9 $FINAL_ZIP * -x *placeholder
