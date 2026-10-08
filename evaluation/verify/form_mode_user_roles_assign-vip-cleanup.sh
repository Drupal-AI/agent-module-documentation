#!/usr/bin/env bash
# Introspection CLEANUP: clear the mapping. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_user_roles_assign.settings")->set("form_modes",[])->save();' >/dev/null 2>&1
echo "cleanup: form_modes cleared"
