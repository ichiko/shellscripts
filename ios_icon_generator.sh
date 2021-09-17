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

for n_size in ${L_SIZE[@]}; do
	convert -resize ${n_size}x${n_size} $1 $2/${F_NAME}_${n_size}.${F_EXT}
done
