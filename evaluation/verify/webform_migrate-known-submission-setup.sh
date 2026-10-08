#!/usr/bin/env bash
# Introspection SETUP: create migrate_plus.migration config entity wm_known_migration referencing
# webform_migrate source plugin d7_webform_submission -> destination entity:webform_submission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if (!$s->load("wm_known_migration")) {
    $s->create([
      "id" => "wm_known_migration", "label" => "WM Known Submission", "migration_group" => "default",
      "source" => ["plugin" => "d7_webform_submission"],
      "process" => ["id" => "webform_id"],
      "destination" => ["plugin" => "entity:webform_submission"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migrate_plus.migration.wm_known_migration (source=d7_webform_submission destination=entity:webform_submission)"
