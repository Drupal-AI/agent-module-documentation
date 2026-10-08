#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_ui_patterns): uninstall the integration submodule to restore
# baseline (leaves ui_patterns and ui_styles in place). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ui_styles_ui_patterns -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ui_styles_ui_patterns uninstalled"
