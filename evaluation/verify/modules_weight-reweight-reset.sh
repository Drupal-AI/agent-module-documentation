#!/usr/bin/env bash
# Execution RESET (modules_weight): force the modules_weight module's own weight back to 0, so
# verify FAILS until the agent changes it to 5. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("modules_weight", 0);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: modules_weight weight set to 0"
