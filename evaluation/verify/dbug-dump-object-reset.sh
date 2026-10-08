#!/usr/bin/env bash
# Execution RESET: remove the output file the agent must create, so verify FAILS on empty
# state. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/dbug-eval-object.html
echo "reset: /tmp/dbug-eval-object.html removed"
