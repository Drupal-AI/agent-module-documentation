#!/usr/bin/env bash
# Introspection SETUP: write a known entity_update.settings excludes list to the live site
# (defaults user + user_role, plus taxonomy_term and menu_link_content). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_update.settings")
    ->set("excludes", [
      "user" => "user",
      "user_role" => "user_role",
      "taxonomy_term" => "taxonomy_term",
      "menu_link_content" => "menu_link_content",
    ])->save();
' >/dev/null 2>&1
echo "setup: entity_update.settings excludes = user, user_role, taxonomy_term, menu_link_content"
