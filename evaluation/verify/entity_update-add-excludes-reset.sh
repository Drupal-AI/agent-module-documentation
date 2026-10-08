#!/usr/bin/env bash
# Execution RESET: put entity_update.settings excludes back to the shipped default
# (user, user_role) so verify FAILS until the agent adds the requested entity types.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_update.settings")
    ->set("excludes", ["user" => "user", "user_role" => "user_role"])->save();
' >/dev/null 2>&1
echo "reset: entity_update.settings excludes = user, user_role"
