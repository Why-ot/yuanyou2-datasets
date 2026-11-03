#!/usr/bin/env bash
# Rebuild the original .bag files from the 90 MB parts and verify their checksums.
#   bash scripts/reassemble.sh [output-dir]     (default: ./bags)
set -eu
here=$(cd "$(dirname "$0")/.." && pwd)
out=${1:-"$here/bags"}
mkdir -p "$out"
for first in "$here"/chunks/*.part-000; do
    [ -e "$first" ] || continue
    name=$(basename "$first" .part-000)
    cat "$here"/chunks/"$name".part-* > "$out/$name"
    printf '  rebuilt %-60s %s\n' "$name" "$(du -h "$out/$name" | cut -f1)"
done
echo
echo "verifying checksums ..."
( cd "$out" && sha256sum -c "$here/manifests/bags.SHA256SUMS" --quiet ) \
    && echo "ALL CHECKSUMS OK" || echo "CHECKSUM MISMATCH"
