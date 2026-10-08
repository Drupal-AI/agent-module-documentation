#!/usr/bin/env bash
# Introspection SETUP: create a namespaced content type stv_content with a string field
# field_stv_known using the Select Text Value 'select_string_textfield' widget configured as
# radio buttons, so an inspecting agent can read back the configured select_type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("stv_content")) { NodeType::create(["type" => "stv_content", "name" => "STV Content"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_stv_known")) {
    FieldStorageConfig::create(["field_name" => "field_stv_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "stv_content", "field_stv_known")) {
    FieldConfig::create(["field_name" => "field_stv_known", "entity_type" => "node", "bundle" => "stv_content", "label" => "Membership Tier"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "stv_content", "default");
  $fd->setComponent("field_stv_known", [
    "type" => "select_string_textfield", "weight" => 50, "region" => "content",
    "settings" => ["select_type" => "radios", "allowed_values" => "Bronze\nSilver\nGold", "custom_value_label" => "Other", "custom_value_field_title" => "", "custom_value_field_description" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.stv_content field_stv_known uses select_string_textfield, select_type=radios"
