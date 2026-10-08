#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_library): uninstall the module to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_library -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ui_styles_library uninstalled"
