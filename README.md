# yuanyou2 recorded rosbags

Recorded capture data from the Yuanyou2 robot. GitHub rejects any single file
above 100 MB and Git LFS proved unreliable for these multi-hundred-megabyte
files, so every bag is stored as **90 MB parts** and rebuilt with a script.

| Directory | Parts | Size | Description |
|---|---|---|---|
| `chunks/` | see `ls chunks | wc -l` | 11 GB | tabletop stage0–stage2 capture runs (2026-08-17 → 2026-08-21) |
| `manifests/bags.SHA256SUMS` | — | 19 lines | checksums of the original `.bag` files |

## Rebuild

```bash
git clone git@github.com:Why-ot/yuanyou2-datasets.git
cd yuanyou2-datasets
bash scripts/reassemble.sh          # writes ./bags/*.bag and verifies checksums
```

The script concatenates `chunks/<name>.bag.part-*` in order and runs
`sha256sum -c manifests/bags.SHA256SUMS`, so you know the rebuilt bags are
byte-identical to the ones on the robot.
