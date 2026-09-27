#!/bin/bash

size=$(stat -c%s "$1") || exit 1

echo "Input size: $size bytes"

dd if=/dev/urandom of="$2" bs=1 count="$size" status=progress || exit 1

python3 - "$1" "$2" "$3" <<'PY'
import sys

with open(sys.argv[1], "rb") as f1, \
     open(sys.argv[2], "rb") as f2, \
     open(sys.argv[3], "wb") as f3:

    while True:
        a = f1.read(1024 * 1024)
        if not a:
            break

        b = f2.read(len(a))
        if len(b) != len(a):
            raise RuntimeError("Random file is shorter than input")

        f3.write(bytes(x ^ y for x, y in zip(a, b)))
PY
