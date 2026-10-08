#!/usr/bin/env bash
# Execution RESET (ui_styles_ui_patterns): uninstall the integration so the ui_styles_attributes
# source is NOT registered, making verify FAIL until the agent enables the module. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_ui_patterns -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ui_styles_ui_patterns uninstalled; ui_styles_attributes source absent"
