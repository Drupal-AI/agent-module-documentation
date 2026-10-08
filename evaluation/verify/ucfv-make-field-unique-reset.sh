#!/usr/bin/env bash
# Execution RESET: ensure a string field field_ucfv_code exists on Article and is NOT unique
# (unique third-party setting removed), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ucfv_code")) {
    FieldStorageConfig::create([
      "field_name" => "field_ucfv_code", "entity_type" => "node",
      "type" => "string",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_ucfv_code");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_ucfv_code", "entity_type" => "node",
      "bundle" => "article", "label" => "UCFV Code",
    ]);
  }
  $fc->unsetThirdPartySetting("unique_content_field_validation", "unique");
  $fc->save();
' >/dev/null 2>&1
echo "reset: field_ucfv_code present, uniqueness OFF"
