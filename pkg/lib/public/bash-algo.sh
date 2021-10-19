# shellcheck shell=bash

algo.base64encode() {
	unset REPLY; REPLY=
	local input="$1"

	local char_str="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local input_byte_{one,two,three}=
	local bits_{one,two,three,four}=
	local output_byte_{one,two,three_four}
	for ((i=0; i<${#input}; i=i+3)); do
		# If there are only two bytes left, the value of third_byte and
		# fourth_byte will both be 0
		printf -v input_byte_one '%d' "'${input:$i:1}"
		printf -v input_byte_two '%d' "'${input:$i+1:1}"
		printf -v input_byte_three '%d' "'${input:$i+2:1}"

		# Output byte one
		bits_one=$(( (input_byte_one >> 2) & 2#00111111 ))
		output_byte_one="${char_str:$bits_one:1}"

		# Output byte two
		bits_two=$(( ((input_byte_one & 2#00000011) << 4) | ((input_byte_two & 2#11110000) >> 4 & 2#00001111) ))
		output_byte_two="${char_str:$bits_two:1}"

		# Output byte three
		if ((input_byte_two == 0)); then
			output_byte_three='='
		else
			bits_three=$(( (input_byte_two & 2#00001111) << 2 | input_byte_three >> 6 & 2#00000011 ))
			output_byte_three="${char_str:$bits_three:1}"
		fi

		# Output byte four
		if ((input_byte_three == 0)); then
			output_byte_four='='
		else
			bits_four=$(( input_byte_three & 2#00111111 ))
			output_byte_four="${char_str:$bits_four:1}"
		fi

		REPLY+="${output_byte_one}${output_byte_two}${output_byte_three}${output_byte_four}"
	done
}
