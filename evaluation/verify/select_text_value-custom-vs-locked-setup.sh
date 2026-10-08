#!/usr/bin/env bash
# Introspection SETUP: content type stv_content with two string fields using Select Text Value
# widgets; field_stv_open has custom_value_label "Other" (free entry), field_stv_locked has
# custom_value_label "" (list only). Agent must read which allows a custom value. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("stv_content")) { NodeType::create(["type" => "stv_content", "name" => "STV Content"])->save(); }
  foreach (["field_stv_open" => "Open Choice", "field_stv_locked" => "Locked Choice"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "string"])->save();
    }
    if (!FieldConfig::loadByName("node", "stv_content", $fn)) {
      FieldConfig::create(["field_name" => $fn, "entity_type" => "node", "bundle" => "stv_content", "label" => $label])->save();
    }
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "stv_content", "default");
  $fd->setComponent("field_stv_open", [
    "type" => "select_string_textfield", "weight" => 51, "region" => "content",
    "settings" => ["select_type" => "select", "allowed_values" => "Red\nGreen\nBlue", "custom_value_label" => "Other", "custom_value_field_title" => "", "custom_value_field_description" => ""],
  ]);
  $fd->setComponent("field_stv_locked", [
    "type" => "select_string_textfield", "weight" => 52, "region" => "content",
    "settings" => ["select_type" => "select", "allowed_values" => "Red\nGreen\nBlue", "custom_value_label" => "", "custom_value_field_title" => "", "custom_value_field_description" => ""],
  ]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_stv_open (custom_value_label=Other) and field_stv_locked (empty) on node.stv_content"
