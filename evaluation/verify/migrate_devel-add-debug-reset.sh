#!/usr/bin/env bash
# Execution RESET: write a migrate_plus migration config (migdev_task) with a plain process
# pipeline and NO migrate_devel debug step, so verify FAILS until the agent adds one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("migrate_plus.migration.migdev_task")->setData([
    "id" => "migdev_task", "label" => "MigDev task", "migration_group" => "default",
    "source" => ["plugin" => "embedded_data", "data_rows" => [["id" => 1, "title" => "x", "body" => "y"]], "ids" => ["id" => ["type" => "integer"]]],
    "process" => [
      "title" => "title",
      "body" => "body",
    ],
    "destination" => ["plugin" => "entity:node", "default_bundle" => "article"],
  ])->save();
' >/dev/null 2>&1
echo "reset: migrate_plus.migration.migdev_task present with no debug step"
