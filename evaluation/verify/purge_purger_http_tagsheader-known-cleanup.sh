#!/usr/bin/env bash
# Introspection CLEANUP (purge_purger_http_tagsheader): baseline is 'enabled', so this restores
# nothing but re-asserts the module is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx purge_purger_http_tagsheader \
  || drush en purge_purger_http_tagsheader -y >/dev/null 2>&1
echo "cleanup: purge_purger_http_tagsheader left enabled (baseline)"
