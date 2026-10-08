#!/usr/bin/env bash
# Execution CLEANUP (purge_purger_http_tagsheader): restore baseline by (re-)enabling the
# submodule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx purge_purger_http_tagsheader \
  || drush en purge_purger_http_tagsheader -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: purge_purger_http_tagsheader re-enabled (baseline restored)"
