#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default library location (cdn, per config/install).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views_timelinejs.settings")->set("library_location", "cdn")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views_timelinejs.settings:library_location restored to cdn"
