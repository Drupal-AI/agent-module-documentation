#!/usr/bin/env bash
# Execution CLEANUP (shortcutperrole, layman): remove the authenticated mapping. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shortcutperrole.settings")
    ->clear("role.authenticated")->save();
' >/dev/null 2>&1 || true
echo "cleanup: role.authenticated removed"
exit 0
