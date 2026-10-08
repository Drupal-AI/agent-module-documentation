#!/usr/bin/env bash
# Execution RESET: ensure a multi-value list_string checkboxes field field_ms_task exists on
# Article, and force multiple_select.settings to NOT include it (so verify FAILS until the
# agent enables the helper for it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ms_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_ms_task", "entity_type" => "node",
      "type" => "list_string", "cardinality" => -1,
      "settings" => ["allowed_values" => ["x" => "Xray", "y" => "Yankee", "z" => "Zulu"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ms_task")) {
    FieldConfig::create([
      "field_name" => "field_ms_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Options",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_ms_task", ["type" => "options_buttons", "weight" => 50, "region" => "content"])->save();
  \Drupal::configFactory()->getEditable("multiple_select.settings")->set("table", NULL)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ms_task present, multiple_select.settings table cleared"
