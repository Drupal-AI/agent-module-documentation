#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_views): uninstall the module (its hook_uninstall removes
# 'ui_styles' from views.settings.display_extenders), restoring baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_views -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ui_styles_views uninstalled"
