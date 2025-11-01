#!/bin/bash

function error() {
    echo "$@" > /dev/stderr
    exit 1
}

function usage() {
    echo "exenv <PID> <command> [args]"
    exit "$1"
}

[[ $1 == --help ]] && usage 0
[[ $# -lt 2 ]] && usage 1

PID="$1"
shift

COMMAND=( "$@" )

environ="/proc/$PID/environ"
[[ ! -f $environ ]] && error "PID doesn't exist"
[[ ! -r $environ ]] && error "Permission denied to read environment file of process $pid"

escaped_command="$(printf "%q " "${COMMAND[@]}")"

exec xargs -a "$environ" -0 bash -c 'env -i "$@" '"${escaped_command}"
