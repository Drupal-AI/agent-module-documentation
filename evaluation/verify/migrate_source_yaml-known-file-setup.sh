#!/usr/bin/env bash
# Introspection SETUP: create a migrate_plus migration (msy_known) using the yaml source reading
# /var/www/html/msy_known.yml, so an agent can read the source file path from live config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $data = [
    "id" => "msy_known", "label" => "MSY known",
    "migration_tags" => [], "migration_group" => "default",
    "source" => ["plugin" => "yaml", "file" => "/var/www/html/msy_known.yml", "ids" => ["id" => ["type" => "integer"]]],
    "process" => ["title" => "title"],
    "destination" => ["plugin" => "entity:node", "default_bundle" => "article"],
    "migration_dependencies" => [],
  ];
  \Drupal::configFactory()->getEditable("migrate_plus.migration.msy_known")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migration msy_known reads /var/www/html/msy_known.yml"
