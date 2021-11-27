#!/usr/bin/env bash

load './util/init.sh'

@test "base32_encode" {
	algo.base32_encode 'guatemala-hondorus'
	assert [ "$REPLY" = 'M52WC5DFNVQWYYJNNBXW4ZDPOJ2XG===' ]

	test_util.base32_encode 'A'
	test_util.base32_encode 'AB'
	test_util.base32_encode 'ABC'
	test_util.base32_encode 'ABCD'
	test_util.base32_encode 'ABCDE'
	test_util.base32_encode 'WOOF'
	test_util.base32_encode 'kafka38quebec'
	test_util.base32_encode 'EcHo##8(0}}'
}

@test "base32_decode" {
	algo.base32_decode 'M52WC5DFNVQWYYJNNBXW4ZDPOJ2XG==='
	assert [ "$REPLY" = 'guatemala-hondorus' ]

	test_util.base32_decode 'IE======'
	test_util.base32_decode 'IFBA===='
	test_util.base32_decode 'IFBEG==='
	test_util.base32_decode 'IFBEGRA='
	test_util.base32_decode 'IFBEGRCF'
	test_util.base32_decode 'K5HU6RQ='
	test_util.base32_decode 'NNQWM23BGM4HC5LFMJSWG==='
	test_util.base32_decode 'IVRUQ3ZDEM4CQMD5PU======'
}

@test "base64_encode" {
	algo.base64_encode 'paraguay-uruguay'
	assert [ "$REPLY" = 'cGFyYWd1YXktdXJ1Z3VheQ==' ]

	test_util.base64_encode 'A'
	test_util.base64_encode 'AB'
	test_util.base64_encode 'ABC'
	test_util.base64_encode 'ABCD'
	test_util.base64_encode 'WOOF'
	test_util.base64_encode 'kafka38quebec'
	test_util.base64_encode 'EcHo##8(0}}'
}

@test "base64_decode" {
	algo.base64_decode 'cGFyYWd1YXktdXJ1Z3VheQ=='
	assert [ "$REPLY" = 'paraguay-uruguay' ]

	test_util.base64_decode 'QQ=='
	test_util.base64_decode 'QUI='
	test_util.base64_decode 'QUJD'
	test_util.base64_decode 'QUJDRA=='
	test_util.base64_decode 'V09PRg=='
	test_util.base64_decode 'a2Fma2EzOHF1ZWJlYw=='
	test_util.base64_decode 'RWNIbyMjOCgwfX0='

	test_util.base64_decode 'Z3VhdGVtYWxhLWhvbmRvcnVz'
	test_util.base64_decode 'YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXo='
	test_util.base64_decode 'YXNsZGZramFzbDtka2ZqYTtzbGRrZmphO2xzZGtqZmE7bGtkc2pmO2xha2pkZnFvcHdlcmlydWpwb2Zpc2R1amxranZoeGtjbGp2YnNmZGtsamhhYmxlcnVocW9wZWlydWhmZG9pdXNqYmh2Y2tsc2poYmRmaW9wcXdlcnVkaGZxd29waWVkZnVoYWxpc2tkamZnYmhpd3FvdWVnaHJ0b3FpdWVyaHBmZHNpb2F1aHBxb2FpdWRoZnNrbGpmaGFsc2tkamZoYXEyMzA5LXU4d3BvZWk7IGFzZGxmamhxaXV3b2pFSA=='
}
