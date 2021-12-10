#!/usr/bin/env bash

load './util/init.sh'

@test "url encode works" {
	algo.uri_encode "abc#\\^"

	assert [ "$REPLY" = 'abc#%5C%5E' ]
}

@test "url decode works" {
	algo.uri_decode 'abc#%5C%5E'

	assert [ "$REPLY" = "abc#\\^" ]
}
