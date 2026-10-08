#!/usr/bin/env bash
# Execution RESET: ensure integer field field_rs_task exists on Article and force its form-display
# widget to the plain core 'number' widget (so verify FAILS until switched to range_slider).
# Uses the display repository (creates the display if missing). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_rs_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_rs_task", "entity_type" => "node", "type" => "integer",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_rs_task")) {
    FieldConfig::create([
      "field_name" => "field_rs_task", "entity_type" => "node",
      "bundle" => "article", "label" => "RS Task",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_rs_task", [
    "type" => "number", "weight" => 51, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_rs_task present with core number widget"
