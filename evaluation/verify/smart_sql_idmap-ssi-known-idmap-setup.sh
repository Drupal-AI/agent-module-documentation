#!/usr/bin/env bash
# Introspection SETUP: create a migrate_plus migration config entity that uses the
# smart_sql id map, so an inspecting agent can read back its idMap plugin. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if (!$s->load("ssi_known")) {
    $s->create([
      "id" => "ssi_known", "label" => "SSI known migration",
      "migration_tags" => [], "idMap" => ["plugin" => "smart_sql"],
      "source" => ["plugin" => "embedded_data", "data_rows" => [], "ids" => ["id" => ["type" => "integer"]]],
      "process" => [], "destination" => ["plugin" => "null"],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: migrate_plus.migration.ssi_known uses idMap.plugin=smart_sql"
