#!/usr/bin/env bash
# Execution RESET: ensure content type single_datetime_eval + datetime field field_sdt_task
# exist, with field_sdt_task on the default form display using core's datetime_default widget
# (NOT the Single DateTimePicker). verify FAILs until the agent switches the widget. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("single_datetime_eval")) {
    NodeType::create(["type" => "single_datetime_eval", "name" => "Single Datetime Eval"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_sdt_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_sdt_task", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "single_datetime_eval", "field_sdt_task")) {
    FieldConfig::create([
      "field_name" => "field_sdt_task", "entity_type" => "node",
      "bundle" => "single_datetime_eval", "label" => "Task Date",
    ])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.single_datetime_eval.default")
    ?: $s->create(["targetEntityType" => "node", "bundle" => "single_datetime_eval", "mode" => "default", "status" => TRUE]);
  $fd->setComponent("field_sdt_task", ["type" => "datetime_default", "weight" => 20, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_sdt_task uses datetime_default (not the picker)"
