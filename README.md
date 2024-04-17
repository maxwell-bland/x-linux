# X-Linux : Compile the Linux Kernel for All Microarchitectures
Now 100% Docker-free!

This project provides some hack bash scripts to perform compilation of the
linux kernel for 22 different microarchitectures.

However, you may also be looking for Intel's 0day system (and this may 
be exactly what you are looking for!)

https://github.com/intel/lkp-tests

(In a Debian development environment.)

Some steps (installing compilers stored behind login systems) are manual.

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

See `supported_arches.txt`.

## A note on arch/hexagon

The hexagon support in the linux kernel comes from an old target of the QCOM
comet processor, and I spent a while trying to get the current Hexagon SDK to
support compiling Linux for the comet, but the original and modern hexagon-gcc
are lost to time and kernel support, as the assembler creates trouble for the
modern build system. If some QCOM engineer knows a way to restore support,
please open a pull request or email me at mbland@motorola.com.

More details on comet are given by Rob Landley at
`https://landley.net/notes-2012.html#24-02-2012`.

## TODO

- Some of the compilers could probably be fetched via buildroot.
- Develop scripts to deploy a minimal busybox+QEMU for each arch
- Randomize kernel configs when compiling and running
