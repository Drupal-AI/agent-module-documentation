#!/usr/bin/env bash
# Execution CLEANUP: uninstall and delete the module built for the spec-url page case.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
. agent-module-documentation/evaluation/verify/_openapi_ui_redoc-safe-remove.sh
safe_remove oui_redoc_eval_page
drush cr >/dev/null 2>&1
echo "cleanup: oui_redoc_eval_page uninstalled and deleted"
