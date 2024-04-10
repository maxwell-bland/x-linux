#!/usr/bin/bash
DIR=$(realpath $(dirname ${BASH_SOURCE[0]}))
tmp=$(mktemp)

"$DIR"/get_compilers.sh | tee "$tmp"
if [[ "$?" != "0" ]]; then
	exit 1
fi
export PATH=$(cat "$tmp" | tail -n1)
rm "$tmp"
"$DIR"/compile.sh $@
