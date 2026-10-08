#!/usr/bin/env bash
# Execution RESET: clear theme switcher config so verify (node_contributor=admin) FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_manager_theme_switcher.settings")->set("type",[])->set("form_mode",[])->save();' >/dev/null 2>&1
echo "reset: theme switcher config cleared"
