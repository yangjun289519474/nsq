#!/bin/bash
set -e

#future1, add sume function
#this is my first future

GOMAXPROCS=1 go test -timeout 90s ./...
GOMAXPROCS=4 go test -timeout 90s -race ./...

# no tests, but a build is something
for dir in apps/*/ bench/*/; do
    dir=${dir%/}
    if grep -q '^package main$' $dir/*.go 2>/dev/null; then
        echo "building $dir"
        go build -o $dir/$(basename $dir) ./$dir
    else
        echo "(skipped $dir)"
    fi
done
