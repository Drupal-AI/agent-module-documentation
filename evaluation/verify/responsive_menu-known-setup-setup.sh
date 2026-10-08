#!/usr/bin/env bash
# Introspection SETUP: write a KNOWN responsive_menu.settings configuration to the live site
# so an inspecting agent can read it back via drush. Sets a distinctive combination:
#   horizontal_menu = admin, off_canvas_menus = footer, horizontal_breakpoint = Large,
#   off_canvas_position = right, off_canvas_theme = theme-white, drag = TRUE.
# Idempotent: overwrites any prior values. Exits 0.
set -uo pipefail
cd /var/www/html
drush cset responsive_menu.settings horizontal_menu admin -y >/dev/null 2>&1
drush cset responsive_menu.settings off_canvas_menus footer -y >/dev/null 2>&1
drush cset responsive_menu.settings horizontal_breakpoint Large -y >/dev/null 2>&1
drush cset responsive_menu.settings horizontal_media_query '(min-width: 1000px)' -y >/dev/null 2>&1
drush cset responsive_menu.settings off_canvas_position right -y >/dev/null 2>&1
drush cset responsive_menu.settings off_canvas_theme theme-white -y >/dev/null 2>&1
drush cset responsive_menu.settings drag 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: responsive_menu.settings -> horizontal_menu=admin off_canvas_menus=footer horizontal_breakpoint=Large off_canvas_position=right off_canvas_theme=theme-white drag=true"
