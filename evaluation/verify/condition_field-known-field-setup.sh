#!/usr/bin/env bash
# Introspection SETUP: create a condition_field field field_cf_known on Article with request_path
# and user_role enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_cf_known", "entity_type" => "node", "type" => "condition_field",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_cf_known");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_cf_known", "entity_type" => "node",
      "bundle" => "article", "label" => "CF Known",
    ]);
  }
  $fc->setSetting("enabled_plugins", ["request_path" => "request_path", "user_role" => "user_role"]);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_cf_known (condition_field; enabled request_path,user_role)"
