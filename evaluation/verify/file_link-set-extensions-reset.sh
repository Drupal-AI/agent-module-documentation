#!/usr/bin/env bash
# Execution RESET: ensure a file_link field field_flink_cfg exists on Article with the DEFAULT
# allowed extensions (txt only, no pdf), so verify FAILS until the agent allows pdf. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_flink_cfg")) {
    FieldStorageConfig::create([
      "field_name" => "field_flink_cfg", "entity_type" => "node", "type" => "file_link",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_flink_cfg");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_flink_cfg", "entity_type" => "node", "bundle" => "article",
      "label" => "Cfg Download",
    ]);
  }
  $fc->setSetting("file_extensions", "txt");
  $fc->setSetting("no_extension", FALSE);
  $fc->setSetting("deferred_request", FALSE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_flink_cfg present, file_extensions='txt' (no pdf)"
