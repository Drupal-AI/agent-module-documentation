#!/usr/bin/env bash
# Execution CLEANUP: uninstall (pmu FIRST) and remove the jsonapi_hypermedia_task module.
# (uninstall FIRST if enabled, then remove its dir) so verify FAILS until the agent builds a
# LinkProvider plugin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jsonapi_hypermedia_task -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/jsonapi_hypermedia_task
drush cr >/dev/null 2>&1
echo "cleanup: uninstalled and removed jsonapi_hypermedia_task"
