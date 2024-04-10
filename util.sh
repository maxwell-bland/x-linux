#!/usr/bin/bash

declare -A CROSS_COMPILE_PREFIX
declare -A CROSS_COMPILE_EXTRA

initialize_cross_compile_prefixes () {
	CROSS_COMPILE_PREFIX[alpha]=alpha-linux-gnu-
	CROSS_COMPILE_PREFIX[arc]=arc-linux-gnu-
	CROSS_COMPILE_PREFIX[arm]=arm-linux-gnueabi-
	CROSS_COMPILE_PREFIX[arm64]=aarch64-linux-gnu-
	CROSS_COMPILE_PREFIX[csky]=csky-unknown-linux-gnu-
	CROSS_COMPILE_PREFIX[hexagon]=hexagon-
	CROSS_COMPILE_PREFIX[loongarch]=loongarch64-unknown-linux-gnu-
	CROSS_COMPILE_PREFIX[m68k]=m68k-linux-gnu-
	CROSS_COMPILE_PREFIX[microblaze]=microblazeel-xilinx-linux-gnu-
	CROSS_COMPILE_PREFIX[mips]=mips-linux-gnu-
	CROSS_COMPILE_PREFIX[nios2]=nios2-elf-
	CROSS_COMPILE_PREFIX[openrisc]=or1k-linux-
	CROSS_COMPILE_PREFIX[parisc]=hppa64-linux-gnu-
	CROSS_COMPILE_PREFIX[powerpc]=powerpc-linux-gnu-
	CROSS_COMPILE_PREFIX[riscv]=riscv64-linux-gnu-
	CROSS_COMPILE_PREFIX[s390]=s390x-linux-gnu-
	CROSS_COMPILE_PREFIX[sh]=sh4-linux-gnu-
	CROSS_COMPILE_PREFIX[sparc]=sparc64-linux-gnu-
	CROSS_COMPILE_PREFIX[um]=
	CROSS_COMPILE_PREFIX[x86]=x86-64-linux-gnu-
	CROSS_COMPILE_PREFIX[xtensa]=xtensa-buildroot-linux-uclibc-
}

export CROSS_COMPILE_PREFIX
