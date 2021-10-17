#!/usr/bin/env bash

load './util/init.sh'

@test "base64encode" {
	algo.base64encode "paraguay-uruguay"
	assert [ "$REPLY" = 'cGFyYWd1YXktdXJ1Z3VheQ==' ]

	test_util.base64encode 'A'
	test_util.base64encode 'AB'
	test_util.base64encode 'ABC'
	test_util.base64encode 'ABCD'
	test_util.base64encode 'WOOF'
	test_util.base64encode 'kafka38quebec'
	test_util.base64encode 'EcHo##8(0}}'
}
