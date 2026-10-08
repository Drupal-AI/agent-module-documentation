#!/usr/bin/env bash
# Introspection SETUP (purge_purger_http_tagsheader): ensure the submodule is enabled so its
# purge_tagsheader plugin is discoverable on the running site. Baseline is enabled; idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx purge_purger_http_tagsheader \
  || drush en purge_purger_http_tagsheader -y >/dev/null 2>&1
echo "setup: purge_purger_http_tagsheader enabled; purge_tagsheader tagsheader plugin available"
