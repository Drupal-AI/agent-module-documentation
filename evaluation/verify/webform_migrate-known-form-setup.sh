#!/usr/bin/env bash
# Introspection SETUP: create migrate_plus.migration config entity wm_known_form referencing
# webform_migrate source plugin d7_webform -> destination entity:webform. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if (!$s->load("wm_known_form")) {
    $s->create([
      "id" => "wm_known_form", "label" => "WM Known Form", "migration_group" => "default",
      "source" => ["plugin" => "d7_webform"],
      "process" => ["id" => "webform_id"],
      "destination" => ["plugin" => "entity:webform"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migrate_plus.migration.wm_known_form (source=d7_webform destination=entity:webform)"
