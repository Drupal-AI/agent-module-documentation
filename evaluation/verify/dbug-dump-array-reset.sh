#!/usr/bin/env bash
# Execution RESET: remove the output file the agent is expected to create, so verify FAILS
# until the agent generates the dbug dump. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/dbug-eval-array.html
echo "reset: /tmp/dbug-eval-array.html removed"
