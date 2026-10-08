#!/usr/bin/env bash
# Introspection SETUP: make content_editor and administrator the assignable roles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("roleassign.settings")
    ->set("roleassign_roles", ["content_editor"=>"content_editor","administrator"=>"administrator"])->save();
' >/dev/null 2>&1
echo "setup: roleassign_roles=[content_editor, administrator]"
