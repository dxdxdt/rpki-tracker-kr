open_db () {
	cat bangbang - | nc whois.radb.net 43
}

extract_answer () {
	set -e
	local c
	local l
	local eot

	while read l
	do
		c="${l:0:1}"

		if [ "$c" == "A" ]; then
			c="${l:1}"
			read -N "$c" l
			# consume "C"
			read eot && [ "$eot" == "C" ] || echo "Protocol error" >&2 || exit 1
			printf '%s\0' "$l"
		elif [ "$c" == "%" ]; then
			read
			printf '\0'
		elif [ "$c" == "D" ]; then
			printf '\0'
		fi
	done
}
