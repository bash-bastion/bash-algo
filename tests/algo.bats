#!/usr/bin/env bash

load './util/init.sh'

@test "base32_encode" {
	algo.base32_encode --as-arg 'guatemala-hondorus'
	assert [ "$REPLY" = 'M52WC5DFNVQWYYJNNBXW4ZDPOJ2XG===' ]

	test_util.base32_encode --as-arg 'A'
	test_util.base32_encode --as-arg 'AB'
	test_util.base32_encode --as-arg 'ABC'
	test_util.base32_encode --as-arg 'ABCD'
	test_util.base32_encode --as-arg 'ABCDE'
	test_util.base32_encode --as-arg 'WOOF'
	test_util.base32_encode --as-arg 'kafka38quebec'
	test_util.base32_encode --as-arg 'EcHo##8(0}}'
}

@test "base32_decode" {
	algo.base32_decode --as-arg 'M52WC5DFNVQWYYJNNBXW4ZDPOJ2XG==='
	assert [ "$REPLY" = 'guatemala-hondorus' ]

	test_util.base32_decode --as-arg 'IE======'
	test_util.base32_decode --as-arg 'IFBA===='
	test_util.base32_decode --as-arg 'IFBEG==='
	test_util.base32_decode --as-arg 'IFBEGRA='
	test_util.base32_decode --as-arg 'IFBEGRCF'
	test_util.base32_decode --as-arg 'K5HU6RQ='
	test_util.base32_decode --as-arg 'NNQWM23BGM4HC5LFMJSWG==='
	test_util.base32_decode --as-arg 'IVRUQ3ZDEM4CQMD5PU======'
}

@test "base64_encode" {
	algo.base64_encode --as-arg 'paraguay-uruguay'
	assert [ "$REPLY" = 'cGFyYWd1YXktdXJ1Z3VheQ==' ]

	test_util.base64_encode --as-arg 'A'
	test_util.base64_encode --as-arg 'AB'
	test_util.base64_encode --as-arg 'ABC'
	test_util.base64_encode --as-arg 'ABCD'
	test_util.base64_encode --as-arg 'WOOF'
	test_util.base64_encode --as-arg 'kafka38quebec'
	test_util.base64_encode --as-arg 'EcHo##8(0}}'
}

@test "base64_decode" {
	algo.base64_decode --as-arg 'cGFyYWd1YXktdXJ1Z3VheQ=='
	assert [ "$REPLY" = 'paraguay-uruguay' ]

	test_util.base64_decode --as-arg 'QQ=='
	test_util.base64_decode --as-arg 'QUI='
	test_util.base64_decode --as-arg 'QUJD'
	test_util.base64_decode --as-arg 'QUJDRA=='
	test_util.base64_decode --as-arg 'V09PRg=='
	test_util.base64_decode --as-arg 'a2Fma2EzOHF1ZWJlYw=='
	test_util.base64_decode --as-arg 'RWNIbyMjOCgwfX0='

	test_util.base64_decode --as-arg 'Z3VhdGVtYWxhLWhvbmRvcnVz'
	test_util.base64_decode --as-arg 'YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXo='
	test_util.base64_decode --as-arg 'YXNsZGZramFzbDtka2ZqYTtzbGRrZmphO2xzZGtqZmE7bGtkc2pmO2xha2pkZnFvcHdlcmlydWpwb2Zpc2R1amxranZoeGtjbGp2YnNmZGtsamhhYmxlcnVocW9wZWlydWhmZG9pdXNqYmh2Y2tsc2poYmRmaW9wcXdlcnVkaGZxd29waWVkZnVoYWxpc2tkamZnYmhpd3FvdWVnaHJ0b3FpdWVyaHBmZHNpb2F1aHBxb2FpdWRoZnNrbGpmaGFsc2tkamZoYXEyMzA5LXU4d3BvZWk7IGFzZGxmamhxaXV3b2pFSA=='
}
