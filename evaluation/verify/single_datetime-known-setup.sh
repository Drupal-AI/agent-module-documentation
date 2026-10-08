#!/usr/bin/env bash
# Introspection SETUP: create content type single_datetime_eval + a datetime field
# field_sdt_known using the single_date_time_widget with known settings (hour_format=12h,
# allow_times=30) on the default form display, so an agent can read back which field uses the
# Single DateTimePicker widget and its hour format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("single_datetime_eval")) {
    NodeType::create(["type" => "single_datetime_eval", "name" => "Single Datetime Eval"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_sdt_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_sdt_known", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "single_datetime_eval", "field_sdt_known")) {
    FieldConfig::create([
      "field_name" => "field_sdt_known", "entity_type" => "node",
      "bundle" => "single_datetime_eval", "label" => "Known Event",
    ])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.single_datetime_eval.default")
    ?: $s->create(["targetEntityType" => "node", "bundle" => "single_datetime_eval", "mode" => "default", "status" => TRUE]);
  $fd->setComponent("field_sdt_known", [
    "type" => "single_date_time_widget", "weight" => 20, "region" => "content",
    "settings" => ["hour_format" => "12h", "allow_times" => "30"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: single_datetime_eval/field_sdt_known uses single_date_time_widget hour_format=12h allow_times=30"
