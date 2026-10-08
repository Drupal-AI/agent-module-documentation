#!/usr/bin/env bash
# Execution RESET: ensure ape_test is uninstalled so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush pmu ape_test -y >/dev/null 2>&1 || true
echo "reset: ape_test uninstalled"
