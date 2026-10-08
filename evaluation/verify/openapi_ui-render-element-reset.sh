#!/usr/bin/env bash
# Execution RESET for the "render an OpenAPI doc via the openapi_ui element" hard case.
# Clears state: uninstall and delete the module the agent is asked to create
# (openapi_ui_eval_render). Idempotent. Paths relative to the Drupal root (/var/www/html).
set -uo pipefail
cd /var/www/html

drush pmu openapi_ui_eval_render -y >/dev/null 2>&1
rm -rf web/modules/custom/openapi_ui_eval_render
drush cr >/dev/null 2>&1
echo "reset: module openapi_ui_eval_render uninstalled and removed"
