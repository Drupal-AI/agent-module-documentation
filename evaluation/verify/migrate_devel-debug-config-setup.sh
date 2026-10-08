#!/usr/bin/env bash
# Introspection SETUP: write a migrate_plus migration config (migdev_known) whose 'body' field
# process pipeline contains a migrate_devel 'debug' step configured with dump: source, so an
# agent can read it back from config storage (bypasses the migration plugin manager).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("migrate_plus.migration.migdev_known")->setData([
    "id" => "migdev_known", "label" => "MigDev known", "migration_group" => "default",
    "source" => ["plugin" => "embedded_data", "data_rows" => [["id" => 1, "body" => "x"]], "ids" => ["id" => ["type" => "integer"]]],
    "process" => [
      "title" => "id",
      "body" => [
        ["plugin" => "debug", "source" => "body", "dump" => "source"],
      ],
    ],
    "destination" => ["plugin" => "entity:node", "default_bundle" => "article"],
  ])->save();
' >/dev/null 2>&1
echo "setup: migrate_plus.migration.migdev_known has a debug step (dump: source) on the body field"
