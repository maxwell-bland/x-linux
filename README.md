# X-Linux : Compile the Linux Kernel for All Microarchitectures
Now 100% Docker-free!

This project provides some hack bash scripts to perform compilation of the
linux kernel for 21 different microarchitectures.

(In a Debian development environment.)

Some steps (installing compilers behind proprietary account systems) are
manual, but if we build a bypass for QCOM's silly login system, etc, e.g.
through bs4 and selenium, I'll merge it.

Please also feel free to submit improvements!

Dedicated to David Hildenbrand and Christophe Leroy.

## Running

TL;DR 
```
cd <linux kernel source directory>
~/x-linux/x-linux.sh
```

More in depth:

- `./get_compilers.sh` has shell scripts to grab specific compilers for
  specific microarchitectures.
- `./compile.sh` should be run inside the linux kernel directory and attempts
  to `make clean; make defconfig; make` For each supported architecture,
  storing compilation results into `build_log_$arch.txt` files.

## Supported Architectures

```
alpha
arc
arm
arm64
csky
hexagon
loongarch
m68k
microblaze
mips
nios2
openrisc
parisc
powerpc
riscv
s390
sh
sparc
um
x86
xtensa
```

This list should match `supported_arches.txt`.

## TODO

- Some of the compilers could probably be fetched via buildroot.
- Develop scripts to deploy a minimal busybox+QEMU for each arch
- Randomize kernel configs when compiling and running
