# shellcheck shell=bash

algo.base32encode() {
	unset REPLY; REPLY=
	local input="$1"

	local char_str='ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'
	local input_byte_{one,two,three,four,five}=
	local bits_{one,two,three,four,five,six,seven,eight}=
	local output_byte_{one,two,three,four,five,six,seven,eight}=
	for ((i=0; i<${#input}; i=i+5)); do
		printf -v input_byte_one '%d' "'${input:$i:1}"
		printf -v input_byte_two '%d' "'${input:$i+1:1}"
		printf -v input_byte_three '%d' "'${input:$i+2:1}"
		printf -v input_byte_four '%d' "'${input:$i+3:1}"
		printf -v input_byte_five '%d' "'${input:$i+4:1}"

		# Output byte one
		bits_one=$(( (input_byte_one >> 3) & 2#00011111 ))
		output_byte_one="${char_str:$bits_one:1}"

		# Output byte two
		bits_two=$(( ((input_byte_one & 2#00000111) << 2) | ((input_byte_two & 2#11000000) >> 6) ))
		output_byte_two="${char_str:$bits_two:1}"

		# Output byte three
		if ((input_byte_two == 0)); then
			output_byte_three='='
		else
			bits_three=$(( (input_byte_two >> 1) & 2#00011111 ))
			output_byte_three="${char_str:$bits_three:1}"
		fi

		# Output byte four
		if ((input_byte_two == 0)); then
			output_byte_four='='
		else
			bits_four=$(( ((input_byte_two & 2#00000001) << 4) | ((input_byte_three & 2#11110000) >> 4) ))
			output_byte_four="${char_str:$bits_four:1}"
		fi

		# Output byte five
		if ((input_byte_three == 0)); then
			output_byte_five='='
		else
			bits_five=$(( ((input_byte_three & 2#00001111) << 1) | ((input_byte_four & 2#10000000) >> 7) ))
			output_byte_five="${char_str:$bits_five:1}"
		fi

		# Output byte six
		if ((input_byte_four == 0)); then
			output_byte_six='='
		else
			bits_six=$(( (input_byte_four >> 2) & 2#00011111 ))
			output_byte_six="${char_str:$bits_six:1}"
		fi

		# Output byte seven
		if ((input_byte_four == 0)); then
			output_byte_seven='='
		else
			bits_seven=$(( (input_byte_four & 2#00000011) << 3 | ((input_byte_five & 2#11100000) >> 5) ))
			output_byte_seven="${char_str:$bits_seven:1}"
		fi

		# Output byte eight
		if ((input_byte_five == 0)); then
			output_byte_eight='='
		else
			bits_eight=$(( input_byte_five & 2#00011111 ))
			output_byte_eight="${char_str:$bits_eight:1}"
		fi

		REPLY+="${output_byte_one}${output_byte_two}${output_byte_three}${output_byte_four}${output_byte_five}${output_byte_six}${output_byte_seven}${output_byte_eight}"
	done; unset i
}

algo.base32decode() {
	unset REPLY; REPLY=
	local input="$1"

	local char_str='ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'
	local input_byte_{one,two,three,four,five,six,seven,eight}=
	local index_{one,two,three,four,five,six,seven,eight}=
	local bits_{one,two,three,four,five}=
	local output_byte_{one,two,three,four,five}=
	for ((i=0; i<${#input}; i=i+8)); do
		printf -v input_byte_one '%c' "${input:$i:1}"
		printf -v input_byte_two '%c' "${input:$i+1:1}"
		printf -v input_byte_three '%c' "${input:$i+2:1}"
		printf -v input_byte_four '%c' "${input:$i+3:1}"
		printf -v input_byte_five '%c' "${input:$i+4:1}"
		printf -v input_byte_six '%c' "${input:$i+5:1}"
		printf -v input_byte_seven '%c' "${input:$i+6:1}"
		printf -v input_byte_eight '%c' "${input:$i+7:1}"

		# Equivalent to char_str.indexOf(input)
		index_one="${char_str%$input_byte_one*}"; index_one=${#index_one}
		index_two="${char_str%$input_byte_two*}"; index_two=${#index_two}
		index_three="${char_str%$input_byte_three*}"; index_three=${#index_three}
		index_four="${char_str%$input_byte_four*}"; index_four=${#index_four}
		index_five="${char_str%$input_byte_five*}"; index_five=${#index_five}
		index_six="${char_str%$input_byte_six*}"; index_six=${#index_six}
		index_seven="${char_str%$input_byte_seven*}"; index_seven=${#index_seven}
		index_eight="${char_str%$input_byte_eight*}"; index_eight=${#index_eight}

		# Output byte one
		bits_one=$(( ((index_one & 2#00011111) << 3) | ((index_two >> 2) & 2#00000111) ))
		printf -v output_byte_one '%03o' "$bits_one"
		printf -v output_byte_one "\\$output_byte_one"

		# TODO `if ((index_two === 32)) ...` required?
		# An index of '32' means char_str.`indexOf(input)` could not find the substring
		# i.e. `-1` in traditional languages. This occurs when an `=` is found

		# Output byte two
		bits_two=$(( ((index_two & 2#00000011) << 6) | ((index_three & 2#00011111) << 1) | ((index_four & 2#10000000) >> 7)  ))
		printf -v output_byte_two '%03o' "$bits_two"
		printf -v output_byte_two "\\$output_byte_two"

		# Output byte three
		bits_three=$(( ((index_four & 2#00001111) << 4) | ((index_five & 2#00011110) >> 1) ))
		printf -v output_byte_three '%03o' "$bits_three"
		printf -v output_byte_three "\\$output_byte_three"

		# Output byte four
		bits_four=$(( ((index_five & 2#00000001) << 7) | ((index_six & 2#00011111) << 2) | ((index_seven & 2#00011000) >> 3) ))
		printf -v output_byte_four '%03o' "$bits_four"
		printf -v output_byte_four "\\$output_byte_four"

		# Output byte five
		bits_five=$(( ((index_seven & 2#00000111) << 5) | (index_eight & 2#00011111) ))
		printf -v output_byte_five '%03o' "$bits_five"
		printf -v output_byte_five "\\$output_byte_five"

		REPLY+="${output_byte_one}${output_byte_two}${output_byte_three}${output_byte_four}${output_byte_five}"
	done; unset i
}

algo.base64encode() {
	unset REPLY; REPLY=
	local input="$1"

	local char_str='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
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
	done; unset i
}

algo.base64decode() {
	unset REPLY; REPLY=
	local input="$1"

	local char_str='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	local input_byte_{one,two,three,four}=
	local index_{one,two,three,four}=
	local output_byte_{one,two,three}=
	for ((i=0; i<${#input}; i=i+4)); do
		printf -v input_byte_one '%c' "${input:$i:1}"
		printf -v input_byte_two '%c' "${input:$i+1:1}"
		printf -v input_byte_three '%c' "${input:$i+2:1}"
		printf -v input_byte_four '%c' "${input:$i+3:1}"

		# TODO: `set -o nocasematch` likely affects this
		# Equivalent to char_str.indexOf(input)
		index_one="${char_str%$input_byte_one*}"; index_one=${#index_one}
		index_two="${char_str%$input_byte_two*}"; index_two=${#index_two}
		index_three="${char_str%$input_byte_three*}"; index_three=${#index_three}
		index_four="${char_str%$input_byte_four*}"; index_four=${#index_four}

		# Output byte one
		bits_one=$(( ((index_one & 2#00111111) << 2) | ((index_two >> 4) & 2#00000011) ))
		printf -v output_byte_one '%03o' "$bits_one"
		printf -v output_byte_one "\\$output_byte_one"

		# An index of '64' means char_str.`indexOf(input)` could not find the substring
		# i.e. `-1` in traditional languages. This occurs when an `=` is found

		# Output byte two
		if ((index_three == 64)); then
			output_byte_two=
		else
			bits_two=$(( ((index_two & 2#00001111) << 4) | ((index_three >> 2) & 2#00001111) ))
			printf -v output_byte_two '%03o' "$bits_two"
			printf -v output_byte_two "\\$output_byte_two"
		fi

		# Output byte three
		if ((index_four == 64)); then
			output_byte_three=
		else
			bits_three=$(( ((index_three & 2#00000011) << 6) | (index_four & 2#00111111) ))
			printf -v output_byte_three '%03o' "$bits_three"
			printf -v output_byte_three "\\$output_byte_three"
		fi

		REPLY+="${output_byte_one}${output_byte_two}${output_byte_three}"
	done; unset i
}
