#!/usr/bin/env bash

set -euo pipefail

while read -r line; do
    if [ -n "$line" ]; then
        dir="$(cut -d ' ' -f1 <<< "$line")"
        url="$(cut -d ' ' -f2 <<< "$line")"
        if [ -z "$dir" ]; then
            echo "Invalid directory"
            exit 1
        fi
        if [ -z "$url" ]; then
            echo "Invalid URL"
            exit 1
        fi
        mkdir -p "$dir"
        wget -nc -t 0 -P "$dir" "$url" || true
    fi
done < /dev/stdin

