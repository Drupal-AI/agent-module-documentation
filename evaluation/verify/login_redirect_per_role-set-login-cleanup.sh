#!/usr/bin/env bash
# Execution CLEANUP: delete login_redirect_per_role.settings, restoring baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("login_redirect_per_role.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: login_redirect_per_role.settings deleted (baseline)"
