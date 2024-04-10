#!/usr/bin/bash

DIR=$(realpath $(dirname ${BASH_SOURCE[0]}))
source "$DIR"/util.sh

check_compiler () {
	local arch=$1
	compiler=$(which ${CROSS_COMPILE_PREFIX[$arch]}gcc)
	if [[ "$compiler" == "" ]]; then
		compiler=$(which ${CROSS_COMPILE_PREFIX[$arch]}clang)
	fi
	echo $compiler
}

find_compiler () {
	local arch=$1
	compiler=$(find "$DIR"/compilers/$arch/ -name ${CROSS_COMPILE_PREFIX[$arch]}gcc)
	if [[ "$compiler" == "" ]]; then
		compiler=$(find "$DIR"/compilers/$arch/ -name ${CROSS_COMPILE_PREFIX[$arch]}clang)
	fi
	echo $compiler
}

add_compiler () {
	local arch=$1
	compiler=$(find_compiler $arch)
	if [[ "$compiler" == "" ]]; then 
		echo "Could not find $arch compiler in $DIR/compilers/$arch!"
	else
		export PATH=$(dirname $compiler):$PATH
		echo "Added $arch compiler at $(dirname $compiler)"
	fi
}

# ============= COMPILER FETCH ROUTINES ============= 

get_csky() {
	pushd "$DIR"/compilers/
	git clone https://github.com/c-sky/toolchain-build.git csky
	sudo apt-get install \
		autoconf automake autotools-dev curl python3 \
		libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
		bison flex texinfo gperf libtool patchutils \
		bc zlib1g-dev libexpat-dev python-is-python3
	cd csky
	git submodule update --init
	./build-csky-gcc.py csky-gcc --src ./ --triple csky-unknown-linux-gnu
	popd
}

get_loongarch () {
	echo 'Please fetch the latest
	x86_64-cross-tools-loongarch64-gcc-libc.tar.xz from
	https://github.com/loongson/build-tools/releases/ and add it under
	'$DIR/compilers/loongarch'!'
	echo "type enter when done!"
	read
}

get_microblaze () {
	echo 'Please get the microblaze SDK from
	https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis.html'
	echo "Then make a symlink to
	/tools/Xilinx/Vitis/2023.2/gnu/microblaze/linux_toolchain/lin64_le/bin/
	through $DIR/compilers/microblaze"
	echo "Press enter when done"
	read
}

get_nios2 () {
	echo 'This one is ugly, nios2 is discontinued. Thankfully nios2 is part
	of the qurtus prime lite toolchain at
	https://www.intel.com/content/www/us/en/software-kit/795187/intel-quartus-prime-lite-edition-design-software-version-23-1-for-linux.html'
	echo 'Then, the nios2 dev kit is inside the resulting directories,'
	echo 'typically this will be
	intelFPGA_lite/23.1std/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin/'
	echo "make a symlink to this directory through $DIR/compilers/nios2"
	read
}

get_openrisc () {
	echo "Please fetech the lastest
	or1k-linux-12.0.1-20220210-20220304.tar.xz from https://github.com/openrisc/or1k-gcc/releases/
	and add it under $DIR/compilers/openrisc !"
	echo "Press enter when done!"
	read
}

get_parisc () {
	sudo apt install gcc-hppa-linux-gnu gcc-hppa64-linux-gnu
}

get_xtensa () {
	pushd $DIR/compilers/
	git clone git://git.buildroot.net/buildroot xtensa
	cd xtensa
	mkdir buildroot-build
	echo 'Buildroot packages the xtensa build chain'
	echo 'Select 'Target Architecture' = Xtensa, 'Target Architecture Variant' = Custom Xtensa processor configuration on the next screen, no need to set up a custom kernel since you ostensibly already have a kernel checkout you are working from'
	echo 'press enter to continue'
	read line
	make O=$(pwd)/buildroot-build menuconfig
	make O=$(pwd)/buildroot-build
	popd
}

get_alpha () {
	sudo apt install gcc-alpha-linux-gnu
}

get_arc () {
	sudo apt install gcc-arc-linux-gnu
}

get_arm () {
	sudo apt install gcc-arm-linux-gnueabi
}

get_aarch64 () {
	sudo apt install gcc-aarch64-linux-gnu
}

get_m68k () {
	sudo apt install gcc-m68k-linux-gnu
}

get_mips () {
	sudo apt install gcc-mips-linux-gnu
}

get_powerpc () {
	sudo apt install gcc-powerpc-linux-gnu
}

get_riscv () {
	sudo apt install gcc-riscv64-linux-gnu
}

get_s390 () {
	sudo apt install gcc-s390x-linux-gnu
}

get_sh () {
	sudo apt install gcc-sh4-linux-gnu
}

get_sparc () {
	sudo apt install gcc-sparc64-linux-gnu
}

get_um () {
	echo 'Assuming Linux UML is x86_64 and host is x86_64'
}

get_x86 () {
	echo 'Assuming x86_64 compiler is host compiler'
}

# ============= MAIN ============= 

register_compiler () {
	local arch=$1
	compiler=$(check_compiler $arch)
	if [[ "$compiler" == "" ]]; then
		compiler=$(find_compiler $arch)
		if [[ "$compiler" == "" ]]; then 
			get_$arch
		fi
		add_compiler $arch
	fi
	compiler=$(check_compiler $arch)
	echo "Found $arch compiler at $compiler"
}

initialize_cross_compile_prefixes
arches=$(cat "$DIR"/supported_arches.txt | xargs)
for a in $arches; do
	register_compiler $a
done
echo '---'
echo 'Please set PATH to the following'
echo $PATH
