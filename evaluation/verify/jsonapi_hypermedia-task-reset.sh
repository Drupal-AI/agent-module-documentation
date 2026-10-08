#!/usr/bin/env bash
# Execution RESET: ensure the target fixture module jsonapi_hypermedia_task is absent
# (uninstall FIRST if enabled, then remove its dir) so verify FAILS until the agent builds a
# LinkProvider plugin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jsonapi_hypermedia_task -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/jsonapi_hypermedia_task
drush cr >/dev/null 2>&1
echo "reset: jsonapi_hypermedia_task absent"
