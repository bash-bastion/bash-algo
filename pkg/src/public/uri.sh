# shellcheck shell=bash

# @description URI encode a particular string
# @arg $1 string input
algo.uri_encode() {
	unset -v REPLY
	REPLY=
	local input="$1"

	# https://tc39.es/ecma262/multipage/global-object.html#sec-encodeuri-uri
	local uri_reserved=";/?:@&=+$,"
	local uri_unescaped="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.!~*'()#"

	# shellcheck disable=SC1007
	local i= char=
	for ((i = 0; i < ${#input}; ++i)); do
		char="${input:$i:1}"

		case "${uri_reserved}${uri_unescaped}" in
		*"$char"*)
			REPLY+="$char"
			;;
		*)
			printf -v REPLY '%s%%%02X' "$REPLY" "'$char"
			;;
		esac
	done

	printf '%s\n' "$REPLY"
}

# @description URI decode a particular string
# @arg $1 string input
algo.uri_decode() {
	unset -v REPLY
	REPLY=
	local input="$1"

	local url_encoded="${input//+/ }"
	printf -v REPLY '%b' "${url_encoded//%/\\x}"
}
