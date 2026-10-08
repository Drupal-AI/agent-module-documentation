#!/usr/bin/env bash
# Execution RESET for the "build a custom JSON:API resource" hard case.
# Clears state so the case starts empty: uninstall and delete the module the agent is asked to
# create (jsonapi_resources_eval_build) so no route with a _jsonapi_resource default from it
# exists in the route table.
# Idempotent. Paths relative to the Drupal root (/var/www/html).
set -uo pipefail
cd /var/www/html

drush pmu jsonapi_resources_eval_build -y >/dev/null 2>&1
rm -rf web/modules/custom/jsonapi_resources_eval_build
drush cr >/dev/null 2>&1
echo "reset: module jsonapi_resources_eval_build uninstalled and removed"
