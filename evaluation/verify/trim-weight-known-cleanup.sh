#!/usr/bin/env bash
# Introspection CLEANUP: restore Trim's shipped default module weight (1001). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("trim", 1001);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: trim module weight restored to 1001"
