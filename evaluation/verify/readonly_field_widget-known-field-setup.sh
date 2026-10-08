#!/usr/bin/env bash
# Introspection SETUP: create a string field on Article, set its default form-display
# widget to readonly_field_widget with a known formatter_type ("string"), so an
# inspecting agent can read back the field name and formatter_type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rofw_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_rofw_known", "entity_type" => "node",
      "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_rofw_known")) {
    FieldConfig::create([
      "field_name" => "field_rofw_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Readonly Field",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_rofw_known", [
    "type" => "readonly_field_widget", "weight" => 50, "region" => "content",
    "settings" => [
      "label" => "above",
      "formatter_type" => "string",
      "formatter_settings" => [],
      "show_description" => FALSE,
      "error_validation" => FALSE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_rofw_known widget=readonly_field_widget formatter_type=string"
