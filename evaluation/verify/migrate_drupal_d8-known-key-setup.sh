#!/usr/bin/env bash
# Introspection SETUP: ensure migrate_plus enabled; create a migration mdd8_key using d8_entity with a
# distinctive source database connection key, so an agent can read the key back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en migrate_plus -y >/dev/null 2>&1
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if (Migration::load("mdd8_key")) { Migration::load("mdd8_key")->delete(); }
  Migration::create([
    "id" => "mdd8_key", "label" => "MDD8 key", "migration_group" => "default",
    "source" => ["plugin" => "d8_entity", "key" => "legacy_d8_db", "entity_type" => "taxonomy_term"],
    "process" => ["name" => "name"],
    "destination" => ["plugin" => "entity:taxonomy_term"],
  ])->save();
' >/dev/null 2>&1
echo "setup: migration mdd8_key (d8_entity, key=legacy_d8_db)"
