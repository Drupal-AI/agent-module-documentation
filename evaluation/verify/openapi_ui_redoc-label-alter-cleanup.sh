#!/usr/bin/env bash
# Introspection CLEANUP: uninstall and delete the label fixture module so the redoc plugin
# label returns to its annotated value ("ReDoc"). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
. agent-module-documentation/evaluation/verify/_openapi_ui_redoc-safe-remove.sh
safe_remove oui_redoc_fx_label
drush cr >/dev/null 2>&1
echo "cleanup: oui_redoc_fx_label removed; redoc label back to annotation default"
