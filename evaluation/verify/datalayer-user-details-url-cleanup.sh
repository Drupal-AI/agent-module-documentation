#!/usr/bin/env bash
# MEDIUM cleanup: restore expose_user_details to its install default (empty).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("expose_user_details", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: datalayer.settings expose_user_details restored to empty"
