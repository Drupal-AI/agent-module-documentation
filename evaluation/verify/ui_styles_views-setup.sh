#!/usr/bin/env bash
# Introspection SETUP (ui_styles_views): enable the module so its Views display extender is
# registered in views.settings.display_extenders for the agent to read. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_views -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ui_styles_views enabled; 'ui_styles' added to views.settings display_extenders"
