#!/usr/bin/env bash
# Execution RESET: remove the output file so verify FAILS until the agent regenerates it from
# cl_editorial's component manager. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f /tmp/cl_editorial_stable_ids.txt
echo "reset: /tmp/cl_editorial_stable_ids.txt removed"
