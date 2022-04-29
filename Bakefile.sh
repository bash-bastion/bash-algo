# shellcheck shell=bash

task.test() {
	bats ./tests
}

task.docs() {
	for f in algo pem uri; do
		shdoc < "./pkg/src/public/$f.sh" > "./docs/$f.md"
	done
}