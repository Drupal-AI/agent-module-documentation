#!/usr/bin/env bash
# Introspection CLEANUP: restore the responsive_menu.settings keys touched by the matching
# setup script back to their install defaults (config/install/responsive_menu.settings.yml).
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush cset responsive_menu.settings horizontal_menu main -y >/dev/null 2>&1
drush cset responsive_menu.settings off_canvas_menus main -y >/dev/null 2>&1
drush cset responsive_menu.settings horizontal_breakpoint wide -y >/dev/null 2>&1
drush cset responsive_menu.settings horizontal_media_query '(min-width: 960px)' -y >/dev/null 2>&1
drush cset responsive_menu.settings off_canvas_position left -y >/dev/null 2>&1
drush cset responsive_menu.settings off_canvas_theme theme-dark -y >/dev/null 2>&1
drush cset responsive_menu.settings drag 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: responsive_menu.settings restored to install defaults"
