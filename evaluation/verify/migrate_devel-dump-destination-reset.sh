#!/usr/bin/env bash
# Execution RESET: write a migrate_plus migration config (migdev_dump) with a process pipeline
# and NO debug step, so verify FAILS until the agent adds a debug step that dumps the whole
# destination (dump: destination).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("migrate_plus.migration.migdev_dump")->setData([
    "id" => "migdev_dump", "label" => "MigDev dump", "migration_group" => "default",
    "source" => ["plugin" => "embedded_data", "data_rows" => [["id" => 1, "title" => "x"]], "ids" => ["id" => ["type" => "integer"]]],
    "process" => [
      "title" => "title",
    ],
    "destination" => ["plugin" => "entity:node", "default_bundle" => "article"],
  ])->save();
' >/dev/null 2>&1
echo "reset: migrate_plus.migration.migdev_dump present with no debug step"
