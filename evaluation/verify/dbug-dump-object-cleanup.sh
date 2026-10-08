#!/usr/bin/env bash
# Execution CLEANUP: remove the output file. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/dbug-eval-object.html
echo "cleanup: /tmp/dbug-eval-object.html removed"
