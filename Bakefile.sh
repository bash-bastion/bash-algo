# shellcheck shell=bash

task.test() {
	bats ./tests
}

task.docs() {
	shdoc < './pkg/lib/public/bash-algo.sh' > './docs/algo.md'
	for f in pem uri; do
		shdoc < "./pkg/lib/public/$f.sh" > "./docs/$f.md"
	done
}