#!/usr/bin/env bash
# Execution RESET: ensure a string field field_rofw_desc exists on Article using the
# NORMAL string_textfield widget on the default form display (so verify FAILS until the
# agent switches it to readonly_field_widget with formatter_type=string). Creates the
# field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rofw_desc")) {
    FieldStorageConfig::create([
      "field_name" => "field_rofw_desc", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_rofw_desc")) {
    FieldConfig::create([
      "field_name" => "field_rofw_desc", "entity_type" => "node",
      "bundle" => "article", "label" => "Description Field",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_rofw_desc", [
    "type" => "string_textfield", "weight" => 50, "region" => "content",
    "settings" => ["size" => 60, "placeholder" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_rofw_desc present with widget=string_textfield"
