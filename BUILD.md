BASIC BUILD INSTRUCTIONS
--------------------

```bash
cd ~
mkdir -p kernel_build/toolchains & cd kernel_build/toolchains 
```

Download Linaro 4.9.4 Toolchain by Christopher83@XDA (arm-cortex_a7-linux-gnueabihf-linaro_4.9.4-2015.06-build_2015_07_15.tar.xz)

```bash
tar -xvf arm-cortex_a7-linux-gnueabihf-linaro_4.9.4-2015.06-build_2015_07_15.tar.xz
mv arm-cortex_a7-linux-gnueabihf-linaro_4.9.4-2015.06 linaro_4.9.4
cd ..
git clone https://github.com/Joomu/peregrine-kernel.git
chmod +x build_kernel.sh
./build_kernel.sh
```
