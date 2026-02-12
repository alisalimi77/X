#!/usr/bin/env bash
set -euo pipefail

manifest_file="${1:-ci/evidence-manifest.txt}"

if [[ ! -f "$manifest_file" ]]; then
  echo "Manifest not found: $manifest_file" >&2
  exit 2
fi

missing=0
while IFS= read -r artifact || [[ -n "$artifact" ]]; do
  [[ -z "$artifact" ]] && continue
  if [[ ! -s "$artifact" ]]; then
    echo "Missing or empty evidence artifact: $artifact" >&2
    missing=1
  else
    echo "OK: $artifact"
  fi
done < "$manifest_file"

if [[ "$missing" -ne 0 ]]; then
  echo "Evidence gate failed. Generate required artifacts before merging." >&2
  exit 1
fi

echo "Evidence gate passed."
