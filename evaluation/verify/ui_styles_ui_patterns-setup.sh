#!/usr/bin/env bash
# Introspection SETUP (ui_styles_ui_patterns): ensure the integration is enabled so the agent
# can inspect the live ui_patterns source registry for the ui_styles_attributes source.
set -uo pipefail
cd /var/www/html
drush en ui_styles_ui_patterns -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ui_styles_ui_patterns enabled; source ui_styles_attributes registered"
