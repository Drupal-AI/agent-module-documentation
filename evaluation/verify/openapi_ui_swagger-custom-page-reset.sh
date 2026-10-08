#!/usr/bin/env bash
# Execution RESET: uninstall and delete the custom module the agent is asked to build, so
# /openapi-ui-swagger-eval/docs does not exist and verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall openapi_ui_swagger_eval -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/openapi_ui_swagger_eval
drush cr >/dev/null 2>&1
echo "reset: openapi_ui_swagger_eval module uninstalled and removed"
