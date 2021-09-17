#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: \`ios_icon_generator.sh input_png output_dir\`" 1>&2
	exit 1
fi

if [ ! -e $1 ]; then
	echo "the input file is not exist." 1>&2
	exit 1
fi

if [ ! -d $2 ]; then
	echo "the output directory is not exist." 1>&2
	exit 1
fi

if [ -n "$(ls $2)" ]; then
	echo "the output directory is not empty. "
	echo "May be ocurred file overwrite okay ? : [Y]yn"
	read T_IN
	if [ -z "$T_IN" ]; then
		T_IN=y
	fi
	if [ $T_IN != "y" ]; then
		exit 2
	fi
fi

F_NAME=$(basename $1 | sed 's/\.[^\.]*$//')
F_EXT=$(echo $1 | sed 's/^.*\.\([^\.]*\)$/\1/')

L_SIZE=(20 40 60 29 58 76 87 80 120 152 167 180 1024)

L_ARGS=(
	"1024 1"
	"20 1"
	"20 2"
	"20 3"
	"29 1"
	"29 2"
	"29 3"
	"40 1"
	"40 2"
	"40 3"
	"60 2"
	"60 3"
	"76 1"
	"76 2"
	"83.5 2"
)

for i in $(seq 0 ${#L_ARGS[@]}); do
	j=0
	for v in ${L_ARGS[$i]}; do
		if [ $j -eq 0 ]; then
			n_basesize=$v
		elif [ $j -eq 1 ]; then
			n_density=$v
		fi
		j=$((j+1))
	done

	n_size=$(ruby -e "puts (${n_basesize}*${n_density}).to_i")
	convert -resize ${n_size}x${n_size} $1 $2/${F_NAME}_${n_basesize}x${n_basesize}@${n_density}x.${F_EXT}
done
