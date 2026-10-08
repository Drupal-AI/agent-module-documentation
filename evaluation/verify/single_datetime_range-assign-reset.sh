#!/usr/bin/env bash
# Execution RESET: ensure content type sdt_range_eval + daterange field field_sdtr_task exist,
# with field_sdtr_task on the default form display using core's daterange_default widget (NOT the
# Single DateTimePicker range widget). verify FAILs until the agent switches the widget. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("sdt_range_eval")) {
    NodeType::create(["type" => "sdt_range_eval", "name" => "SDT Range Eval"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_sdtr_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_sdtr_task", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "sdt_range_eval", "field_sdtr_task")) {
    FieldConfig::create([
      "field_name" => "field_sdtr_task", "entity_type" => "node",
      "bundle" => "sdt_range_eval", "label" => "Booking Window",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "sdt_range_eval", "default");
  $fd->setComponent("field_sdtr_task", ["type" => "daterange_default", "weight" => 20, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_sdtr_task uses daterange_default (not the picker)"
