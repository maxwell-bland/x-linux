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
		make ARCH=$arch $crossc randconfig';' \
		make ARCH=$arch $crossc $@
	echo make clean';'\
		make ARCH=$arch $crossc randconfig';' \
		make ARCH=$arch $crossc $@
	echo make clean';'\
		make ARCH=$arch $crossc randconfig';' \
		make ARCH=$arch $crossc $@
}

initialize_cross_compile_prefixes
cat "$DIR"/supported_arches.txt | while read a; do
	i=0
	compile_generic $a $@ | while read cmd; do 
		bash -c "$cmd" 2>&1 | tee build_log_${a}_${i}.txt
		i=$(($i+1))
	done
done
