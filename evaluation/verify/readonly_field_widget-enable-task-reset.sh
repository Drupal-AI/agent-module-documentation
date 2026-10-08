#!/usr/bin/env bash
# Execution RESET: ensure a string field field_rofw_task exists on Article using the
# NORMAL string_textfield widget on the default form display (so verify FAILS until the
# agent switches it to readonly_field_widget). Creates the field if missing. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rofw_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_rofw_task", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_rofw_task")) {
    FieldConfig::create([
      "field_name" => "field_rofw_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Field",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_rofw_task", [
    "type" => "string_textfield", "weight" => 50, "region" => "content",
    "settings" => ["size" => 60, "placeholder" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_rofw_task present with widget=string_textfield"
