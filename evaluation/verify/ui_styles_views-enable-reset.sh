#!/usr/bin/env bash
# Execution RESET (ui_styles_views): uninstall the module so 'ui_styles' is NOT in
# views.settings.display_extenders, making verify FAIL until the agent enables it. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_views -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ui_styles_views uninstalled; display extender absent"
