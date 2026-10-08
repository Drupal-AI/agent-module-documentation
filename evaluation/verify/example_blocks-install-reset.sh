#!/usr/bin/env bash
# Execution RESET: uninstall example_blocks so an "enable the module" task genuinely fails until
# performed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu example_blocks -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: example_blocks uninstalled"
