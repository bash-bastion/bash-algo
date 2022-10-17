# shellcheck shell=bash

# @description PEM encode data
# @arg $1 string PEM label
# @arg $2 string PEM contents
# @arg $3 string Output file
algo.pem_encode() {
	local pem_label="$1"
	local pem_contents="$2"
	local file="$3"

	if printf -- '-----BEGIN %s-----\n' "$pem_label" > "$file"; then :; else
		printf '%s\n' "Error: Could not write to file (code $?)" >&2
	fi

	local line=
	while read -rn64 line; do
		if printf '%s\n' "$line" >> "$file"; then :; else
			printf '%s\n' "Error: Could not write to file (code $?)" >&2
		fi
	done <<< "$pem_contents"
	unset line

	if printf -- '-----END %s-----\n' "$pem_label" >> "$file"; then :; else
		printf '%s\n' "Error: Could not write to file (code $?)" >&2
	fi
}

# TODO: implement headers, etc.
# @description PEM decode data
# @arg $1 string input
algo.pem_decode() {
	unset REPLY
	REPLY=
	local input="$1"

	# modes: MODE_INIT, MODE_LABEL, MODE_LABEL_AFTER
	local mode='MODE_INIT'
	local start_str_1='-----BEGIN '
	local start_str_2=$'-----\n'
	local end_str_1='-----END '
	local end_str_2='-----'

	local pem_label=
	local pem_contents=
	local chars=
	local char=
	while read -rN1 char; do
		chars+="$char"

		case "$mode" in
		MODE_INIT)
			if [ "$chars" = "$start_str_1" ]; then
				chars=
				mode='MODE_LABEL'
			fi
			;;
		MODE_LABEL)
			if [ "$char" = '-' ]; then
				chars='-'
				mode='MODE_LABEL_AFTER'
			else
				pem_label+="$char"
			fi
			;;
		MODE_LABEL_AFTER)
			if [ "$chars" = "$start_str_2" ]; then
				mode='MODE_CONTENT'
			fi
			;;
		MODE_CONTENT)
			if [ "$char" = $'\n' ]; then
				mode='MODE_CONTENT_POSSIBLY_END'
			else
				pem_contents+="$char"
			fi
			;;
		MODE_CONTENT_POSSIBLY_END)
			if [ "$char" = '-' ]; then
				chars='-'
				mode='MODE_CONTENT_END'
			else
				pem_contents+="$char"
				mode='MODE_CONTENT'
			fi
			;;
		MODE_CONTENT_END)
			if [ "$chars" = "$end_str_1" ]; then
				# For now, assume the rest of the PEM is valid
				REPLY1="$pem_label"
				REPLY2="$pem_contents"
				return
			fi
			;;
		esac
	done < <(printf '%s' "$1")
	unset -v char

	# TODO: bash-error
	case "$mode" in
	MODE_INIT)
		printf '%s\n' "Could not find start or end of BEGIN statement"
		;;
	MODE_LABEL)
		printf '%s\n' "Could not find end of label"
		;;
	MODE_LABEL_AFTER)
		printf '%s\n' "Could not find end of label end"
		;;
	MODE_CONTENT)
		printf '%s\n' "Could not find end of PEM content"
		;;
	MODE_CONTENT_POSSIBLY_END)
		printf '%s\n' "Could not find start of -----END"
		;;
	esac >&2
}
