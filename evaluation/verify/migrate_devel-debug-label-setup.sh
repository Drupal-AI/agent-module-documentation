#!/usr/bin/env bash
# Introspection SETUP: write a migrate_plus migration config (migdev_label) whose 'title' field
# has a migrate_devel 'debug' step carrying a known label, so an agent can read the label back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("migrate_plus.migration.migdev_label")->setData([
    "id" => "migdev_label", "label" => "MigDev label", "migration_group" => "default",
    "source" => ["plugin" => "embedded_data", "data_rows" => [["id" => 1, "title" => "x"]], "ids" => ["id" => ["type" => "integer"]]],
    "process" => [
      "title" => [
        ["plugin" => "debug", "source" => "title", "label" => "MIGDEV-TRACE: "],
      ],
    ],
    "destination" => ["plugin" => "entity:node", "default_bundle" => "article"],
  ])->save();
' >/dev/null 2>&1
echo "setup: migrate_plus.migration.migdev_label debug step on title has label 'MIGDEV-TRACE: '"
