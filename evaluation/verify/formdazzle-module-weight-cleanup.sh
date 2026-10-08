#!/usr/bin/env bash
# Introspection CLEANUP: restore formdazzle's module weight to its shipped default of 10
# (set by formdazzle_install). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("formdazzle", 10);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: formdazzle module weight restored to 10"
