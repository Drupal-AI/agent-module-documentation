#!/usr/bin/env bash
# MEDIUM setup: enable current-user exposure limited to a known URL pattern.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("expose_user_details", "/node/*")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: datalayer.settings expose_user_details = /node/*"
