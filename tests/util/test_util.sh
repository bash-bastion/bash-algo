# shellcheck shell=bash

test_util.base32_encode() {
	algo.base32_encode "$@"
	
	local expected=
	if [ "$1" = '--use-arg' ]; then
		expected=$(printf '%s' "$2" | base32)
	elif [ "$1" = '--use-stdin' ]; then
		expected=$(base32 < "$2")
	else
		printf '%s\n' "Error: test_util: Incorrect arguments passed"
	fi
	
	assert [ "$REPLY" = "$expected" ]
}

test_util.base32_decode() {
	algo.base32_decode "$@"
	
	local expected=
	if [ "$1" = '--use-arg' ]; then
		expected=$(printf '%s' "$2" | base32 --decode)
	elif [ "$1" = '--use-stdin' ]; then
		expected=$(base32 --decode)
	else
		printf '%s\n' "Error: test_util: Incorrect arguments passed"
	fi
	
	assert [ "$REPLY" = "$expected" ]
}

test_util.base64_encode() {
	algo.base64_encode "$@"
	
	local expected=
	if [ "$1" = '--use-arg' ]; then
		expected=$(printf '%s' "$2" | base64)
	elif [ "$1" = '--use-stdin' ]; then
		expected=$(base64)
	else
		printf '%s\n' "Error: test_util: Incorrect arguments passed"
	fi
	
	assert [ "$REPLY" = "$expected" ]
}

test_util.base64_decode() {
	algo.base64_decode "$@"
	
	local expected=
	if [ "$1" = '--use-arg' ]; then
		expected=$(printf '%s' "$2" | base64 --decode)
	elif [ "$1" = '--use-stdin' ]; then
		expected=$(base64 --decode)
	else
		printf '%s\n' "Error: test_util: Incorrect arguments passed"
	fi
	
	assert [ "$REPLY" = "$expected" ]
}
