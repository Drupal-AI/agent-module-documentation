#!/usr/bin/env bash
# Execution RESET: ensure a JSON field field_jfw_task exists on Article and force its default
# form-display widget back to the plain json_textarea, so verify FAILS until the agent
# switches it to json_editor in "code" mode. Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jfw_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_jfw_task", "entity_type" => "node", "type" => "json",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jfw_task")) {
    FieldConfig::create([
      "field_name" => "field_jfw_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Editor Payload",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_jfw_task", [
    "type" => "json_textarea", "weight" => 66, "region" => "content",
    "settings" => ["rows" => 5, "placeholder" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_jfw_task uses json_textarea"
