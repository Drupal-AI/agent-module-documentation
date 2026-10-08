#!/usr/bin/env bash
# Execution CLEANUP (modules_weight): restore the modules_weight module's weight to 0 (baseline).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("modules_weight", 0);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: modules_weight weight restored to 0"
