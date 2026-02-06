# shellcheck shell=bash

load './util/init.sh'

# @test "str.compare()" {
# 	str.compare 'omicron' 'phi'
# 	assert [ "$REPLY" = -1 ]

# 	# str.compare 'z' 'phi'
# 	# assert [ "$REPLY" = 1 ]

# 	# str.compare 'z' 'z'
# 	# assert [ "$REPLY" = 0 ]
# }

@test "str.contains()" {
	assert str.contains 'apple' 'a'
	assert str.contains 'newsworthy' 'worthy'
	assert str.contains 'a b c d' 'b c'

	refute str.contains 'one' 'two'
}

@test "str.count()" {
	str.count 'apple apple' 'pp'
	assert [ "$REPLY" -eq 2 ]

	str.count 'seven' 'eight'
	assert [ "$REPLY" -eq 0 ]

	str.count 'several overalls error orient right-clicker' 'er'
	assert [ "$REPLY" -eq 4 ]
}

@test "str.fields()" {
	str.fields 'a'
	assert [ "${#REPLY[@]}" -eq 1 ]
	assert [ "${REPLY[0]}" = 'a' ]

	str.fields 'omicron	three   phi'
	assert [ "${#REPLY[@]}" -eq 3 ]
	assert [ "${REPLY[0]}" = 'omicron' ]
	assert [ "${REPLY[1]}" = 'three' ]
	assert [ "${REPLY[2]}" = 'phi' ]
}

@test "str.has_prefix()" {
	assert str.has_prefix 'onerous' 'one'
	refute str.has_prefix 'psi' 'phi'
}

@test "str.has_suffix()" {
	assert str.has_suffix 'highlighter' 'lighter'
	refute str.has_suffix 'psi' 'phi'
}

@test "str.index()" {
	str.index 'highlighter' 'lighter'
	assert [ "$REPLY" -eq 4 ]

	str.index 'electrocardiogram' 'electro'
	assert [ "$REPLY" -eq 0 ]

	str.index 'toilette oil' 'oi'
	assert [ "$REPLY" -eq 1 ]

	str.index 'silber' 'gold'
	assert [ "$REPLY" -eq -1 ]
}

@test "str.join()" {
	local -a arr1=(rot orange gelb blau)
	str.join 'arr1' '|'
	assert [ "$REPLY" = 'rot|orange|gelb|blau' ]

	local -a arr2=()
	str.join 'arr2' '|'
	assert [ "$REPLY" = '' ]
}

@test "str.last_index()" {
	str.last_index 'highlighter' 'lighter'
	assert [ "$REPLY" -eq 4 ]

	str.last_index 'electrocardiogram' 'electro'
	assert [ "$REPLY" -eq 0 ]

	str.last_index 'toilette oil' 'oi'
	assert [ "$REPLY" -eq 9 ]

	str.last_index 'silber' 'gold'
	assert [ "$REPLY" -eq -1 ]
}
