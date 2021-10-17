# shellcheck shell=bash

algo.base64encode() {
	unset REPLY; REPLY=
	local input="$1"

	local char_str="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local has_{second,third}_byte=
	local {first,second,third}_{byte,char}=
	for ((i=0; i<${#input}; i=i+3)); do
		has_second_byte=
		has_third_byte=

		# These branches execute if the string's length isn't divisible by 3. i.e., it
		# is divisible by 2 or only 1 (has lengths of 4, or 5). The i+1 is skipped because
		# it will always be true due to the condition in the for loop
		printf -v first_byte '%d' "'${input:$i:1}"

		# TODO: can simplify if empty string results in 0
		if ((i+2 > ${#input})); then
			second_byte=$((2#00000000))
		else
			has_second_byte=yes
			printf -v second_byte '%d' "'${input:$i+1:1}"
		fi

		if ((i+3 > ${#input})); then
			third_byte=$((2#00000000))
		else
			has_third_byte=yes
			printf -v third_byte '%d' "'${input:$i+2:1}"
		fi

		new_first_bits=$(( (first_byte >> 2) & 2#00111111 ))
		new_second_bits=$(( ((first_byte & 2#00000011) << 4) | ((second_byte & 2#11110000) >> 4 & 2#00001111) ))
		new_third_bits=$(( (second_byte & 2#00001111) << 2 | third_byte >> 6 & 2#00000011 ))
		new_fourth_bits=$(( third_byte & 2#00111111 ))

		first_char="${char_str:$new_first_bits:1}"
		second_char="${char_str:$new_second_bits:1}"

		if [ "$has_second_byte" = yes ]; then
			third_char="${char_str:$new_third_bits:1}"
		else
			third_char='='
		fi
		if [ "$has_third_byte" = yes ]; then
			fourth_char="${char_str:$new_fourth_bits:1}"
		else
			fourth_char='='
		fi

		REPLY+="$first_char$second_char$third_char$fourth_char"
	done
}
