#!/usr/bin/env bash
# Execution RESET: ensure fixture module jsonapi_hypermedia_res is absent (uninstall FIRST, then
# remove dir) so verify FAILS until the agent builds a resource_object LinkProvider. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu jsonapi_hypermedia_res -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/jsonapi_hypermedia_res
drush cr >/dev/null 2>&1
echo "reset: jsonapi_hypermedia_res absent"
