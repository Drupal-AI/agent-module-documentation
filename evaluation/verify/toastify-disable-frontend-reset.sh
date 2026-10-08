#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore both Toastify "enable_for" toggles to their shipped
# default (both TRUE) so verify FAILS until the agent disables the frontend theme. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toastify.settings")->set("enable_for.admin_theme", TRUE)->set("enable_for.frontend_theme", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: toastify.settings enable_for.admin_theme=TRUE frontend_theme=TRUE (defaults)"
