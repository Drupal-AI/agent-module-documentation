#!/usr/bin/env bash
# Execution RESET for the "ReDoc page from a spec URL" case.
# Removes any previous attempt (module oui_redoc_eval_page) and any library fixture that could
# repoint the ReDoc JS, so the route 404s and verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
. agent-module-documentation/evaluation/verify/_openapi_ui_redoc-safe-remove.sh
safe_remove oui_redoc_eval_page
safe_remove oui_redoc_fx_lib
drush cr >/dev/null 2>&1
echo "reset: oui_redoc_eval_page removed; /oui-redoc-eval/docs does not exist"
