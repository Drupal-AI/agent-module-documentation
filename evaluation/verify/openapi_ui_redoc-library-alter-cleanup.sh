#!/usr/bin/env bash
# Introspection CLEANUP: uninstall and delete the library fixture module so the
# openapi_ui_redoc/redoc library reverts to the URL shipped in the module's libraries.yml.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
. agent-module-documentation/evaluation/verify/_openapi_ui_redoc-safe-remove.sh
safe_remove oui_redoc_fx_lib
drush cr >/dev/null 2>&1
echo "cleanup: oui_redoc_fx_lib removed; redoc library back to rebilly.github.io URL"
