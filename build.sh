echo -e "Building kernel\n"
export PATH=$PATH:../toolchains/linaro_4.9.4/bin/
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=arm-cortex_a7-linux-gnueabihf-

export KBUILD_BUILD_USER=Joomu
export KBUILD_BUILD_HOST=localhost

make clean
make peregrine_defconfig
make -j5

if [ ! -d ../zip_peregrine ]; then mkdir ../zip_peregrine; fi;
if [ ! -d ../zip_peregrine/system/lib/modules ]; then mkdir -p ../zip_peregrine/system/lib/modules; fi;
if [ ! -d ../release_peregrine ]; then mkdir ../release_peregrine; fi;

# Remove previous modules
if [ -d ../zip_peregrine/system/lib/modules ]; then rm -rf ../zip_peregrine/system/lib/modules/*; fi;

# Create pronto directory
if [ ! -d ../zip_peregrine/system/lib/modules/pronto ]; then mkdir -p ../zip_peregrine/system/lib/modules/pronto; fi;

# Copy modules
find ./ -type f -name '*.ko' -exec cp -f {} ../zip_peregrine/system/lib/modules/ \;
mv ../zip_peregrine/system/lib/modules/wlan.ko ../zip_peregrine/system/lib/modules/pronto/pronto_wlan.ko

# Copy zImage
cp -f arch/arm/boot/zImage-dtb ../zip_peregrine/kernel/;

version="$1";

# Build zip for recovery
zipname="Joomu-Peregrine-v"$version;
cd ../zip_peregrine
zip -r9 $zipname.zip * > /dev/null;
mv -f $zipname.zip ../release_peregrine;

cd ../peregrine-kernel

# Build boot.img
../mkbootimg/mkbootimg --kernel arch/arm/boot/zImage-dtb --ramdisk ../mkbootimg/newramdisk.cpio.gz --cmdline "console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 vmalloc=400M utags.blkdev=/dev/block/platform/msm_sdcc.1/by-name/utags movablecore=160M" --base 0x00000000 --pagesize 2048 --output ../release_peregrine/$zipname.img

# Clean
make clean
