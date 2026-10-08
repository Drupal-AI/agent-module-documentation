#!/usr/bin/env bash
# Execution RESET: content type stv_content with an unlimited-cardinality string field
# field_stv_multi using the plain core string_textfield widget, so verify FAILS until the agent
# switches to the Select Text Value checkboxes widget. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("stv_content")) { NodeType::create(["type" => "stv_content", "name" => "STV Content"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_stv_multi")) {
    FieldStorageConfig::create(["field_name" => "field_stv_multi", "entity_type" => "node", "type" => "string", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "stv_content", "field_stv_multi")) {
    FieldConfig::create(["field_name" => "field_stv_multi", "entity_type" => "node", "bundle" => "stv_content", "label" => "Amenities"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "stv_content", "default");
  $fd->setComponent("field_stv_multi", ["type" => "string_textfield", "weight" => 50, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.stv_content field_stv_multi (unlimited) uses plain string_textfield"
