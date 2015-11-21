echo -e "Building kernel\n"
export PATH=$PATH:../toolchains/linaro_4.9.4/bin/
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=arm-cortex_a7-linux-gnueabihf-

export KBUILD_BUILD_USER=Joomu
export KBUILD_BUILD_HOST=localhost

make clean
make peregrine_test_defconfig
make -j5
