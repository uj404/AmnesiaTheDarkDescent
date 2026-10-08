#!/usr/bin/env bash
set -euo pipefail

# Extract bundled prebuilt dependencies
echo "==> Unpacking HPL2 dependencies..."
cd HPL2
unzip -q -o dependencies.zip -d dependencies

# Repair symlinks stored as plain text inside the archive
echo "==> Restoring Linux symlinks..."
cd dependencies/lib/linux
for f in lib/*.so* lib64/*.so*; do
    if [ -f "$f" ] && [ "$(file -b "$f")" = "ASCII text, with no line terminators" ]; then
        target=$(cat "$f")
        ln -sfn "${target#link }" "$f"
    fi
done

echo "==> Dependencies successfully prepared."
