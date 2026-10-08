#!/usr/bin/env bash
# Execution CLEANUP (shortcutperrole): remove the content_editor mapping. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shortcutperrole.settings")
    ->clear("role.content_editor")->save();
' >/dev/null 2>&1 || true
echo "cleanup: role.content_editor removed"
exit 0
