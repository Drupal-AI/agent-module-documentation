#!/usr/bin/env bash
# Execution RESET for the "build an openapi_ui renderer plugin" hard case.
# Clears state so the case starts empty: uninstall and delete the module the agent is asked
# to create (openapi_ui_eval_build) so `plugin.manager.openapi_ui.ui` has no plugin from it.
# Idempotent. Paths relative to the Drupal root (/var/www/html).
set -uo pipefail
cd /var/www/html

drush pmu openapi_ui_eval_build -y >/dev/null 2>&1
rm -rf web/modules/custom/openapi_ui_eval_build
drush cr >/dev/null 2>&1
echo "reset: module openapi_ui_eval_build uninstalled and removed"
