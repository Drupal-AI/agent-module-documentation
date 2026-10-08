#!/usr/bin/env bash
# Execution RESET: clear role-assign config so verify (user_task -> fmra_task) FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_user_roles_assign.settings")->set("form_modes",[])->save();' >/dev/null 2>&1
echo "reset: form_modes cleared"
