#!/usr/bin/env bash
# Execution RESET: ensure content type single_datetime_eval + datetime field field_sdt_conf
# exist, with field_sdt_conf already using single_date_time_widget but at the DEFAULT
# hour_format (24h). verify FAILs until the agent reconfigures the widget to 12-hour format.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("single_datetime_eval")) {
    NodeType::create(["type" => "single_datetime_eval", "name" => "Single Datetime Eval"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_sdt_conf")) {
    FieldStorageConfig::create([
      "field_name" => "field_sdt_conf", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "single_datetime_eval", "field_sdt_conf")) {
    FieldConfig::create([
      "field_name" => "field_sdt_conf", "entity_type" => "node",
      "bundle" => "single_datetime_eval", "label" => "Appointment",
    ])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.single_datetime_eval.default")
    ?: $s->create(["targetEntityType" => "node", "bundle" => "single_datetime_eval", "mode" => "default", "status" => TRUE]);
  $fd->setComponent("field_sdt_conf", ["type" => "single_date_time_widget", "weight" => 20, "region" => "content", "settings" => ["hour_format" => "24h"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_sdt_conf uses single_date_time_widget hour_format=24h"
