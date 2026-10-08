#!/usr/bin/env bash
# Execution VERIFY: PASS when the agent has produced at least one valid gzip'd tar archive
# anywhere under /tmp/cs_export_out (content_synchronizer writes the export tar.gz relative to
# the destination it is given). exit 0 pass / 1 fail.
set -uo pipefail
dir=/tmp/cs_export_out
if [ -d "$dir" ]; then
  while IFS= read -r f; do
    if gzip -t "$f" 2>/dev/null && tar tzf "$f" >/dev/null 2>&1; then
      echo "PASS found tar.gz export archive: $f"
      exit 0
    fi
  done < <(find "$dir" -type f 2>/dev/null)
fi
echo "FAIL no valid tar.gz export archive under $dir"
exit 1
