#!/usr/bin/env bash
# Execution RESET/CLEANUP: remove the output file so verify FAILS until the agent compiles. Exit 0.
set -uo pipefail
rm -f /tmp/compiler_scss_eval_h1.css
echo "reset: /tmp/compiler_scss_eval_h1.css removed"
