#!/usr/bin/env bash
# Introspection SETUP: create a daterange_timezone field field_drt_known on Article so an agent
# can identify which Article field uses the module's field type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_drt_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_drt_known", "entity_type" => "node",
      "type" => "daterange_timezone", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_drt_known")) {
    FieldConfig::create([
      "field_name" => "field_drt_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Event Range",
    ])->save();
  }
  \Drupal::service("entity_display.repository")->getFormDisplay("node","article")
    ->setComponent("field_drt_known", ["type" => "daterange_timezone"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_drt_known (type daterange_timezone) created"
