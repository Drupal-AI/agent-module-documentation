#!/usr/bin/env bash
# Execution CLEANUP: remove the output file. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/cl_editorial_card_name.txt
echo "cleanup: /tmp/cl_editorial_card_name.txt removed"
