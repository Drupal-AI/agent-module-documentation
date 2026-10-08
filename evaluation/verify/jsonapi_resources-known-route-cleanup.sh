#!/usr/bin/env bash
# Introspection CLEANUP for the jsonapi_resources "known resource route" medium cases.
# Restores baseline: uninstall and delete the jsonapi_resources_eval_fixture module planted by
# jsonapi_resources-known-route-setup.sh, removing the custom resource route from the table.
# Idempotent: a no-op if it was already removed. Paths relative to the Drupal root.
set -uo pipefail
cd /var/www/html

drush pmu jsonapi_resources_eval_fixture -y >/dev/null 2>&1
rm -rf web/modules/custom/jsonapi_resources_eval_fixture
drush cr >/dev/null 2>&1
echo "cleanup: module jsonapi_resources_eval_fixture uninstalled and removed (baseline restored)"
