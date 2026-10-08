#!/usr/bin/env bash
# Execution RESET: force Trim's module weight to 0 (so it would NOT validate first), making
# the verify FAIL until the agent restores a high weight. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("trim", 0);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: trim module weight forced to 0"
