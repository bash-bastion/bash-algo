# shellcheck shell=bash

test_util.base32_encode() {
	algo.base32_encode "$1"
	assert [ "$REPLY" = "$(printf '%s' "$1" | base32)" ]
}

test_util.base32_decode() {
	algo.base32_decode "$1"
	assert [ "$REPLY" = "$(printf '%s' "$1" | base32 --decode)" ]
}

test_util.base64_encode() {
	algo.base64_encode "$1"
	assert [ "$REPLY" = "$(printf '%s' "$1" | base64)" ]
}

test_util.base64_decode() {
	algo.base64_decode "$1"
	assert [ "$REPLY" = "$(printf '%s' "$1" | base64 --decode)" ]
}
