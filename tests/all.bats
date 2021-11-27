#!/usr/bin/env bash

load './util/init.sh'

@test "base32encode" {
	algo.base32encode 'guatemala-hondorus'
	assert [ "$REPLY" = 'M52WC5DFNVQWYYJNNBXW4ZDPOJ2XG===' ]

	test_util.base32encode 'A'
	test_util.base32encode 'AB'
	test_util.base32encode 'ABC'
	test_util.base32encode 'ABCD'
	test_util.base32encode 'ABCDE'
	test_util.base32encode 'WOOF'
	test_util.base64encode 'kafka38quebec'
	test_util.base64encode 'EcHo##8(0}}'
}

@test "base64encode" {
	algo.base64encode 'paraguay-uruguay'
	assert [ "$REPLY" = 'cGFyYWd1YXktdXJ1Z3VheQ==' ]

	test_util.base64encode 'A'
	test_util.base64encode 'AB'
	test_util.base64encode 'ABC'
	test_util.base64encode 'ABCD'
	test_util.base64encode 'WOOF'
	test_util.base64encode 'kafka38quebec'
	test_util.base64encode 'EcHo##8(0}}'
}

@test "base64decode" {
	algo.base64decode 'cGFyYWd1YXktdXJ1Z3VheQ=='
	assert [ "$REPLY" = 'paraguay-uruguay' ]

	test_util.base64decode 'QQ=='
	test_util.base64decode 'QUI='
	test_util.base64decode 'QUJD'
	test_util.base64decode 'QUJDRA=='
	test_util.base64decode 'V09PRg=='
	test_util.base64decode 'a2Fma2EzOHF1ZWJlYw=='
	test_util.base64decode 'RWNIbyMjOCgwfX0='
}
