#!/usr/bin/bash
DIR=$(realpath $(dirname ${BASH_SOURCE[0]}))

"$DIR"/get_compilers.sh
"$DIR"/compile.sh $@
