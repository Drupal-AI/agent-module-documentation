#!/usr/bin/env bash
# Introspection SETUP (migrate_skip_on_404): create a migrate_plus migration config entity
# msk_known whose file process pipeline uses the skip_on_404 plugin, so an inspecting agent
# can read back which guard plugin/method it applies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $store = \Drupal::entityTypeManager()->getStorage("migration");
  if (!$store->load("msk_known")) {
    $store->create([
      "id" => "msk_known", "label" => "MSK known",
      "migration_group" => "default",
      "source" => ["plugin" => "embedded_data",
        "data_rows" => [["id" => 1, "fileurl" => "/does-not-exist.jpg"]],
        "ids" => ["id" => ["type" => "integer"]]],
      "process" => ["uri" => [
        ["plugin" => "skip_on_404", "method" => "row", "source" => "fileurl"],
      ]],
      "destination" => ["plugin" => "null"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migrate_plus.migration.msk_known created (process uri uses skip_on_404 method row)"
