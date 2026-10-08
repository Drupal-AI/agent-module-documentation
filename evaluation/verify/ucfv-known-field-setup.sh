#!/usr/bin/env bash
# Introspection SETUP: create a string field field_ucfv_known on Article and mark it unique via
# unique_content_field_validation. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ucfv_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ucfv_known", "entity_type" => "node",
      "type" => "string",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_ucfv_known");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_ucfv_known", "entity_type" => "node",
      "bundle" => "article", "label" => "UCFV Known Code",
    ]);
  }
  $fc->setThirdPartySetting("unique_content_field_validation", "unique", TRUE);
  $fc->save();
' >/dev/null 2>&1
echo "setup: field_ucfv_known on node.article marked unique"
