#!/usr/bin/env bash
# Introspection CLEANUP: uninstall the jsonapi_hypermedia_ping fixture module (pmu FIRST) then
# remove its directory, restoring baseline (no custom link providers). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jsonapi_hypermedia_ping -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/jsonapi_hypermedia_ping
drush cr >/dev/null 2>&1
echo "cleanup: uninstalled and removed jsonapi_hypermedia_ping"
