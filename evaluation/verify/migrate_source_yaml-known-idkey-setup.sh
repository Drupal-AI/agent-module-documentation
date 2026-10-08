#!/usr/bin/env bash
# Introspection SETUP: create a migrate_plus migration (msy_idkey) whose yaml source declares a
# single id key 'sku', so an agent can read the id-key field from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $data = [
    "id" => "msy_idkey", "label" => "MSY idkey",
    "migration_tags" => [], "migration_group" => "default",
    "source" => ["plugin" => "yaml", "file" => "/var/www/html/msy_idkey.yml", "ids" => ["sku" => ["type" => "string"]]],
    "process" => ["title" => "name"],
    "destination" => ["plugin" => "entity:node", "default_bundle" => "article"],
    "migration_dependencies" => [],
  ];
  \Drupal::configFactory()->getEditable("migrate_plus.migration.msy_idkey")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migration msy_idkey id key = sku"
