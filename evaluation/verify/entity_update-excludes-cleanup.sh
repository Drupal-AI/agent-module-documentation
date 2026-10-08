#!/usr/bin/env bash
# Introspection CLEANUP: restore entity_update.settings excludes to the module's shipped
# default (user, user_role). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_update.settings")
    ->set("excludes", ["user" => "user", "user_role" => "user_role"])->save();
' >/dev/null 2>&1
echo "cleanup: entity_update.settings excludes restored to user, user_role"
