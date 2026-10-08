#!/usr/bin/env bash
# Introspection SETUP: create content type sdt_range_eval + a daterange field field_sdtr_known
# using the Single DateTimePicker range widget (single_date_time_range_widget) with a known
# setting (hour_format=12h, allow_times=30) on the default form display, so an agent can read
# back which field uses the range picker and its hour format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("sdt_range_eval")) {
    NodeType::create(["type" => "sdt_range_eval", "name" => "SDT Range Eval"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_sdtr_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_sdtr_known", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "sdt_range_eval", "field_sdtr_known")) {
    FieldConfig::create([
      "field_name" => "field_sdtr_known", "entity_type" => "node",
      "bundle" => "sdt_range_eval", "label" => "Event Period",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "sdt_range_eval", "default");
  $fd->setComponent("field_sdtr_known", [
    "type" => "single_date_time_range_widget", "weight" => 20, "region" => "content",
    "settings" => ["hour_format" => "12h", "allow_times" => "30"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sdt_range_eval/field_sdtr_known uses single_date_time_range_widget hour_format=12h allow_times=30"
