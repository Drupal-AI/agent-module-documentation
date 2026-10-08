#!/usr/bin/env bash
# Execution RESET: ensure list_string field field_ms_task exists on Article using the core
# 'options_select' widget (NOT multiselect), so verify FAILS until the agent switches it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ms_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_ms_task", "entity_type" => "node", "type" => "list_string",
      "cardinality" => -1,
      "settings" => ["allowed_values" => ["x" => "Xray", "y" => "Yankee", "z" => "Zulu"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ms_task")) {
    FieldConfig::create([
      "field_name" => "field_ms_task", "entity_type" => "node", "bundle" => "article",
      "label" => "MS Task",
    ])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_ms_task", ["type" => "options_select", "weight" => 50, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ms_task present with options_select widget"
