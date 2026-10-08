#!/usr/bin/env bash
# Introspection SETUP (ui_styles_library): ensure the module is enabled so its styles library
# route (/admin/appearance/ui/styles) and permission (access_ui_styles_library) are registered
# for the agent to inspect. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_library -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ui_styles_library enabled; route ui_styles_library.overview + permission access_ui_styles_library registered"
