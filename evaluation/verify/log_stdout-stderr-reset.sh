#!/usr/bin/env bash
# Execution RESET: force use_stderr OFF ('0') so verify FAILS until the agent turns it on.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings use_stderr 0 >/dev/null 2>&1
echo "reset: log_stdout.settings use_stderr=0"
