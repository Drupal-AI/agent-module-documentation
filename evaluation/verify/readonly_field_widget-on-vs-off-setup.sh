#!/usr/bin/env bash
# Introspection SETUP: create two string fields on Article, field_rofw_on using the
# readonly_field_widget widget and field_rofw_off using the normal string_textfield
# widget, so an inspecting agent can determine which one is read-only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_rofw_on" => "Readonly On", "field_rofw_off" => "Readonly Off"] as $name => $label) {
    if (!FieldStorageConfig::loadByName("node", $name)) {
      FieldStorageConfig::create([
        "field_name" => $name, "entity_type" => "node", "type" => "string",
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $name)) {
      FieldConfig::create([
        "field_name" => $name, "entity_type" => "node",
        "bundle" => "article", "label" => $label,
      ])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_rofw_on", [
    "type" => "readonly_field_widget", "weight" => 50, "region" => "content",
    "settings" => [
      "label" => "above", "formatter_type" => "string",
      "formatter_settings" => [], "show_description" => FALSE, "error_validation" => FALSE,
    ],
  ])->save();
  $fd->setComponent("field_rofw_off", [
    "type" => "string_textfield", "weight" => 51, "region" => "content",
    "settings" => ["size" => 60, "placeholder" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_rofw_on=readonly_field_widget field_rofw_off=string_textfield"
