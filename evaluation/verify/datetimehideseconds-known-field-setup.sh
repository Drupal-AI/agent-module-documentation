#!/usr/bin/env bash
# Introspection SETUP: create a datetime field on Article and enable datetimehideseconds
# "Hide seconds" on its widget in the default form display, so an inspecting agent can read
# back which field/widget has the third-party setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dhs_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_dhs_known", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dhs_known")) {
    FieldConfig::create([
      "field_name" => "field_dhs_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Event Time",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dhs_known", [
    "type" => "datetime_default", "weight" => 50, "region" => "content",
    "third_party_settings" => ["datetimehideseconds" => ["hide" => TRUE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_dhs_known (datetime_default) has datetimehideseconds.hide=true"
