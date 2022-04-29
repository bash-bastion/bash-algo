#!/usr/bin/env bash

load './util/init.sh'

@test "base32_encode" {
	algo.base32_encode --use-arg 'guatemala-hondorus'
	assert [ "$REPLY" = 'M52WC5DFNVQWYYJNNBXW4ZDPOJ2XG===' ]

	test_util.base32_encode --use-arg 'A'
	test_util.base32_encode --use-arg 'AB'
	test_util.base32_encode --use-arg 'ABC'
	test_util.base32_encode --use-arg 'ABCD'
	test_util.base32_encode --use-arg 'ABCDE'
	test_util.base32_encode --use-arg 'WOOF'
	test_util.base32_encode --use-arg 'kafka38quebec'
	test_util.base32_encode --use-arg 'EcHo##8(0}}'
	test_util.base32_encode --use-stdin <(printf '%s' 'EcHo##8(0}}') < <(printf '%s' 'EcHo##8(0}}') 
}

@test "base32_decode" {
	algo.base32_decode --use-arg 'M52WC5DFNVQWYYJNNBXW4ZDPOJ2XG==='
	assert [ "$REPLY" = 'guatemala-hondorus' ]

	test_util.base32_decode --use-arg 'IE======'
	test_util.base32_decode --use-arg 'IFBA===='
	test_util.base32_decode --use-arg 'IFBEG==='
	test_util.base32_decode --use-arg 'IFBEGRA='
	test_util.base32_decode --use-arg 'IFBEGRCF'
	test_util.base32_decode --use-arg 'K5HU6RQ='
	test_util.base32_decode --use-arg 'NNQWM23BGM4HC5LFMJSWG==='
	test_util.base32_decode --use-arg 'IVRUQ3ZDEM4CQMD5PU======'
}

@test "base64_encode" {
	algo.base64_encode --use-arg 'paraguay-uruguay'
	assert [ "$REPLY" = 'cGFyYWd1YXktdXJ1Z3VheQ==' ]

	test_util.base64_encode --use-arg 'A'
	test_util.base64_encode --use-arg 'AB'
	test_util.base64_encode --use-arg 'ABC'
	test_util.base64_encode --use-arg 'ABCD'
	test_util.base64_encode --use-arg 'WOOF'
	test_util.base64_encode --use-arg 'kafka38quebec'
	test_util.base64_encode --use-arg 'EcHo##8(0}}'
}

@test "base64_decode" {
	algo.base64_decode --use-arg 'cGFyYWd1YXktdXJ1Z3VheQ=='
	assert [ "$REPLY" = 'paraguay-uruguay' ]

	test_util.base64_decode --use-arg 'QQ=='
	test_util.base64_decode --use-arg 'QUI='
	test_util.base64_decode --use-arg 'QUJD'
	test_util.base64_decode --use-arg 'QUJDRA=='
	test_util.base64_decode --use-arg 'V09PRg=='
	test_util.base64_decode --use-arg 'a2Fma2EzOHF1ZWJlYw=='
	test_util.base64_decode --use-arg 'RWNIbyMjOCgwfX0='

	test_util.base64_decode --use-arg 'Z3VhdGVtYWxhLWhvbmRvcnVz'
	test_util.base64_decode --use-arg 'YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXo='
	test_util.base64_decode --use-arg 'YXNsZGZramFzbDtka2ZqYTtzbGRrZmphO2xzZGtqZmE7bGtkc2pmO2xha2pkZnFvcHdlcmlydWpwb2Zpc2R1amxranZoeGtjbGp2YnNmZGtsamhhYmxlcnVocW9wZWlydWhmZG9pdXNqYmh2Y2tsc2poYmRmaW9wcXdlcnVkaGZxd29waWVkZnVoYWxpc2tkamZnYmhpd3FvdWVnaHJ0b3FpdWVyaHBmZHNpb2F1aHBxb2FpdWRoZnNrbGpmaGFsc2tkamZoYXEyMzA5LXU4d3BvZWk7IGFzZGxmamhxaXV3b2pFSA=='
}
