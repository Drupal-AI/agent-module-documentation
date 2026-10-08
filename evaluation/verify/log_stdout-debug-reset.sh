#!/usr/bin/env bash
# Execution RESET: force severity_level to 3 (Error) so verify FAILS until the agent
# raises it to 7 (Debug). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings severity_level 3 >/dev/null 2>&1
echo "reset: log_stdout.settings severity_level=3"
