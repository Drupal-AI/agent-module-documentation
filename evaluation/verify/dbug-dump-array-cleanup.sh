#!/usr/bin/env bash
# Execution CLEANUP: remove the output file. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/dbug-eval-array.html
echo "cleanup: /tmp/dbug-eval-array.html removed"
