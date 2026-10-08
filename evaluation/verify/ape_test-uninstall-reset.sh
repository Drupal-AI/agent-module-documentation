#!/usr/bin/env bash
# Execution RESET: ensure ape_test is enabled so verify FAILS until the agent uninstalls it.
set -uo pipefail
cd /var/www/html
drush en ape_test -y >/dev/null 2>&1 || true
echo "reset: ape_test enabled"
