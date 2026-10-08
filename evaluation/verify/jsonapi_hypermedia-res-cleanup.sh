#!/usr/bin/env bash
# Execution CLEANUP: uninstall (pmu FIRST) and remove the jsonapi_hypermedia_res module.
# remove dir) so verify FAILS until the agent builds a resource_object LinkProvider. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu jsonapi_hypermedia_res -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/jsonapi_hypermedia_res
drush cr >/dev/null 2>&1
echo "cleanup: uninstalled and removed jsonapi_hypermedia_res"
