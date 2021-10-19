# shellcheck shell=bash

test_util.base64encode() {
	algo.base64encode "$1"
	assert [ "$REPLY" = "$(printf '%s' "$1" | base64)" ]
}

test_util.base64decode() {
	algo.base64decode "$1"
	assert [ "$REPLY" = "$(printf '%s' "$1" | base64 --decode)" ]
}
