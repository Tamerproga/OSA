#!/usr/bin/env bash
set -euo pipefail

IN_FILE="${1:-labs/lab05-encoding/evidence/staff-broken.csv}"
OUT_FILE="${2:-labs/lab05-encoding/evidence/staff-fixed.csv}"

TMP_UTF8="$(mktemp)"
trap 'rm -f "$TMP_UTF8"' EXIT

iconv -f KZ-1048 -t UTF-8 "$IN_FILE" | tr -d '\r' > "$TMP_UTF8"
printf '\xEF\xBB\xBF' > "$OUT_FILE"
cat "$TMP_UTF8" >> "$OUT_FILE"
