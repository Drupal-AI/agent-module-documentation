#!/usr/bin/env bash
# Introspection CLEANUP for the openapi_ui "known renderer plugin" medium cases.
# Restores baseline: uninstall and delete the openapi_ui_eval_fixture module planted by
# openapi_ui-fixture-setup.sh, returning the plugin manager to zero renderer definitions.
# Idempotent: a no-op if it was already removed. Paths relative to the Drupal root.
set -uo pipefail
cd /var/www/html

drush pmu openapi_ui_eval_fixture -y >/dev/null 2>&1
rm -rf web/modules/custom/openapi_ui_eval_fixture
drush cr >/dev/null 2>&1
echo "cleanup: module openapi_ui_eval_fixture uninstalled and removed (baseline restored)"
