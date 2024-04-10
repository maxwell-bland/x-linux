#!/usr/bin/bash

DIR=$(realpath $(dirname ${BASH_SOURCE[0]}))
NUM_CPUS=1
source "$DIR"/util.sh

compile_generic() {
	local arch=$1
	shift;
	local crossc=${CROSS_COMPILE_PREFIX[$arch]}
	if [[ "$crossc" != "" ]]; then
		local crossc=CROSS_COMPILE=$crossc
	fi
	echo make clean';'\
		make ARCH=$arch $crossc defconfig';' \
		make ARCH=$arch $crossc $@
}

initialize_cross_compile_prefixes
cat "$DIR"/supported_arches.txt | while read a; do
	compile_generic $a $@ | while read cmd; do 
		bash -c "$cmd" 2>&1 | tee build_log_$a.txt
	done
done
