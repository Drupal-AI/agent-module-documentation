#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore searchstax.settings untracked_roles to the empty default.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("searchstax.settings")
    ->set("untracked_roles", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: searchstax untracked_roles restored to []"
