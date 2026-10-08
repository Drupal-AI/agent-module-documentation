#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN migrate_plus.migration config entity that uses this
# module's process plugins, so an inspecting agent can read it back. Installs migration
# `mf_eval_known` whose `field_media_image` mapping uses the `image_import` plugin with a
# known set of options (destination public://eval-images/, uid 1, alt image_alt,
# skip_on_missing_source true). Idempotent: overwrites any prior copy. Exits 0.
# Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("migration");
  if ($m = $storage->load("mf_eval_known")) { $m->delete(); }
  $storage->create([
    "id" => "mf_eval_known",
    "label" => "MF eval known import",
    "migration_group" => "default",
    "source" => [
      "plugin" => "embedded_data",
      "data_rows" => [],
      "ids" => ["id" => ["type" => "integer"]],
      "constants" => ["dest" => "public://eval-images/"],
    ],
    "process" => [
      "name" => "name",
      "field_media_image" => [
        "plugin" => "image_import",
        "source" => "image_path",
        "destination" => "constants/dest",
        "uid" => 1,
        "alt" => "image_alt",
        "skip_on_missing_source" => TRUE,
      ],
    ],
    "destination" => ["plugin" => "entity:media", "default_bundle" => "image"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migrate_plus.migration.mf_eval_known installed (field_media_image uses image_import, destination public://eval-images/, uid 1, alt image_alt, skip_on_missing_source true)"
