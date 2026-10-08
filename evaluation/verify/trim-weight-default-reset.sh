#!/usr/bin/env bash
# Execution RESET: mis-set Trim's module weight to 250 (a wrong, non-default value) so the
# verify FAILS until the agent restores the module's exact shipped default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("trim", 250);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: trim module weight forced to 250"
