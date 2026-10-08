#!/usr/bin/env bash
# Introspection SETUP: create a file_link field on Article with known allowed extensions and
# deferred metadata fetching, so an inspecting agent can read back those field settings.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_flink_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_flink_known", "entity_type" => "node", "type" => "file_link",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_flink_known")) {
    FieldConfig::create([
      "field_name" => "field_flink_known", "entity_type" => "node", "bundle" => "article",
      "label" => "Known Download",
      "settings" => ["file_extensions" => "pdf epub", "no_extension" => FALSE, "deferred_request" => TRUE],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_flink_known file_extensions='pdf epub' deferred_request=TRUE"
