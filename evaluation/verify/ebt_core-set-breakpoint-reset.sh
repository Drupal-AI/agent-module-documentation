#!/usr/bin/env bash
# Execution RESET: restore mobile breakpoint to the shipped default 640 so verify FAILS until
# the agent changes it to 500. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ebt_core.settings ebt_core_mobile_breakpoint '640' -y >/dev/null 2>&1
echo "reset: ebt_core_mobile_breakpoint=640"
