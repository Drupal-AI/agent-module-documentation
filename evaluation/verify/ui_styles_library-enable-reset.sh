#!/usr/bin/env bash
# Execution RESET (ui_styles_library): uninstall the module so the styles library route is NOT
# registered, making verify FAIL until the agent enables it. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_library -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ui_styles_library uninstalled; styles library route absent"
