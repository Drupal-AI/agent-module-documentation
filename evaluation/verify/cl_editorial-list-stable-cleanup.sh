#!/usr/bin/env bash
# Execution CLEANUP: remove the output file. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/cl_editorial_stable_ids.txt
echo "cleanup: /tmp/cl_editorial_stable_ids.txt removed"
