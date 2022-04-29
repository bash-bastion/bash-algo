# shellcheck shell=bash

# @description Encodes an arbitrary string to a base32 sequence of characters
# @arg $1 string input
algo.base32_encode() {
	unset REPLY; REPLY=
	
	local flag="$1"
	if [ -z "$flag" ]; then
		core.err_set 'INVALID_ARGS' || return
	fi

	local input_byte_{one,two,three,four,five}=
	if [ "$flag" = '--as-arg' ]; then
		local arg="$2" 
		if [ -z "$arg" ]; then
			core.err_set 'INVALID_ARGS' || return
		fi

		# shellcheck disable=SC1007
		local i= c=
		# shellcheck disable=SC2059
		for ((i=0; i<${#arg}; i=i+5)); do
			c="${arg:$i:1}"; printf -v input_byte_one "${c:+%d}" "'$c"
			c="${arg:$i+1:1}"; printf -v input_byte_two "${c:+%d}" "'$c"
			c="${arg:$i+2:1}"; printf -v input_byte_three "${c:+%d}" "'$c"
			c="${arg:$i+3:1}"; printf -v input_byte_four "${c:+%d}" "'$c"
			c="${arg:$i+4:1}"; printf -v input_byte_five "${c:+%d}" "'$c"
			algo.base32_encode_impl
		done; unset -v i c
	elif [ "$flag" = '--as-stdin' ]; then
		while IFS=' ' read -r input_byte_{one,two,three,four,five}; do
			algo.base32_encode_impl
		done < <(od -An -td1)
	else
		core.err_set 'INVALID_ARGS' || return
	fi
}

# @description Decodes a base32 sequence of characters to a string
# @arg $1 string input
algo.base32_decode() {
	unset REPLY; REPLY=
	
	local flag="$1"
	if [ -z "$flag" ]; then
		core.err_set 'INVALID_ARGS' || return
	fi

	local input_byte_{one,two,three,four,five,six,seven,eight}=
	if [ "$flag" = '--as-arg' ]; then
		local arg="$2" 
		if [ -z "$arg" ]; then
			core.err_set 'INVALID_ARGS' || return
		fi

		# shellcheck disable=SC1007
		local i= c=
		# shellcheck disable=SC2059
		for ((i=0; i<${#arg}; i=i+8)); do
			c="${arg:$i:1}"; printf -v input_byte_one "${c:+%c}" "$c"
			c="${arg:$i+1:1}"; printf -v input_byte_two "${c:+%c}" "$c"
			c="${arg:$i+2:1}"; printf -v input_byte_three "${c:+%c}" "$c"
			c="${arg:$i+3:1}"; printf -v input_byte_four "${c:+%c}" "$c"
			c="${arg:$i+4:1}"; printf -v input_byte_five "${c:+%c}" "$c"
			c="${arg:$i+5:1}"; printf -v input_byte_six "${c:+%c}" "$c"
			c="${arg:$i+6:1}"; printf -v input_byte_seven "${c:+%c}" "$c"
			c="${arg:$i+7:1}"; printf -v input_byte_eight "${c:+%c}" "$c"
			algo.base32_decode_impl
		done; unset -v i c
	elif [ "$flag" = '--as-stdin' ]; then
		while IFS=' ' read -r input_byte_{one,two,three,four,five,six,seven,eight}; do
			algo.base32_decode_impl
		done < <(od -An -td1)
	else
		core.err_set 'INVALID_ARGS' || return
	fi
}

# @description Encodes an arbitrary string to a base32 sequence of characters
# @arg $1 string input
algo.base64_encode() {
	unset REPLY; REPLY=
	
	local flag="$1"
	if [ -z "$flag" ]; then
		core.err_set 'INVALID_ARGS' || return
	fi

	local input_byte_{one,two,three}=
	if [ "$flag" = '--as-arg' ]; then
		local arg="$2" 
		if [ -z "$arg" ]; then
			core.err_set 'INVALID_ARGS' || return
		fi

		# shellcheck disable=SC1007
		local i= c=
		# shellcheck disable=SC2059
		for ((i=0; i<${#arg}; i=i+3)); do
			c="${arg:$i:1}"; printf -v input_byte_one "${c:+%d}" "'$c"
			c="${arg:$i+1:1}"; printf -v input_byte_two "${c:+%d}" "'$c"
			c="${arg:$i+2:1}"; printf -v input_byte_three "${c:+%d}" "'$c"
			algo.base64_encode_impl
		done; unset -v i c
	elif [ "$flag" = '--as-stdin' ]; then
		while IFS=' ' read -r input_byte_{one,two,three}; do
			algo.base64_encode_impl
		done < <(od -An -td1)
	else
		core.err_set 'INVALID_ARGS' || return
	fi
}

# @description Decodes a base64 sequence of characters to a string
# @arg $1 string input
algo.base64_decode() {
	unset REPLY; REPLY=
	
	local flag="$1"
	if [ -z "$flag" ]; then
		core.err_set 'INVALID_ARGS' || return
	fi

	local input_byte_{one,two,three,four}=
	if [ "$flag" = '--as-arg' ]; then
		local arg="$2" 
		if [ -z "$arg" ]; then
			core.err_set 'INVALID_ARGS' || return
		fi

		# shellcheck disable=SC1007
		local i= c=
		# shellcheck disable=SC2059
		for ((i=0; i<${#arg}; i=i+4)); do
			c="${arg:$i:1}"; printf -v input_byte_one "${c:+%c}" "$c"
			c="${arg:$i+1:1}"; printf -v input_byte_two "${c:+%c}" "$c"
			c="${arg:$i+2:1}"; printf -v input_byte_three "${c:+%c}" "$c"
			c="${arg:$i+3:1}"; printf -v input_byte_four "${c:+%c}" "$c"
			algo.base64_decode_impl
		done; unset -v i c
	elif [ "$flag" = '--as-stdin' ]; then
		while IFS=' ' read -r input_byte_{one,two,three,four}; do
			algo.base64_decode_impl
		done < <(od -An -td1)
	else
		core.err_set 'INVALID_ARGS' || return
	fi
}

# @description Encodes an arbitrary string to a base85 sequence of characters
# @arg $1 string input
# @internal
algo.ascii85_encode() {
	unset REPLY; REPLY=
	local input="$1"

	local char_str='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&<>()[]{}@%$#'

	local i=
	for ((i=0; i < ${#input}; i=i+1)); do
		:
	done
}

# @description Decodes a base85 sequence of characters to a string
# @arg $1 string input
# @internal
algo.ascii85_decode() {
	unset REPLY; REPLY=
	local input="$1"
}

# @description Performs the md5 algorithm on an arbitrary string
# @arg $1 string input
# @internal
algo.md5() {
	unset REPLY; REPLY=
	local input="$1"

	local m=${#input}

	local -a T=(
		$((0xD76AA476)) $((0xE8C7B756)) $((0x242070DB)) $((0xC1BDCEEE))
	)

	local A=$((0x01234567))
	local B=$((0x89abcdef))
	local C=$((0xfedcba98))
	local D=$((0x76543210))

	# F

}
