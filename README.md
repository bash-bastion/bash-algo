# bash-algo

Common algorithms implemented in pure Bash

All algorithms use _only_ builtins and create _no subshells_

## Algorithms

- [x] URL encode
- [x] URL decode
- [x] base32 encode
- [x] base32 decode
- [x] base64 encode
- [x] base64 decode
- [ ] ascii85 encode
- [ ] ascii85 decode
- [x] PEM encode
- [x] PEM decode
- [ ] adler32
- [ ] crc32
- [ ] crc64
- [ ] md5
- [ ] sha1
- [ ] sha256
- [x] str.compare
- [x] str.contains
- [x] str.count
- [x] str.fields
- [x] str.has_prefix
- [x] str.has_suffix
- [x] str.index
- [x] str.join
- [x] str.last_index
- [x] str.repeat
- [-] str.replace
- [-] str.replace_all

String manipulation functions modeled from Go's [strings](https://pkg.go.dev/strings) module.

## Roadmap

- Pem_encode/decode uses subshells

## Installation

Use [Basalt](https://github.com/bash-bastion/basalt), a Bash package manager, to add this project as a dependency

```sh
basalt add bash-bastion/bash-algo
```
