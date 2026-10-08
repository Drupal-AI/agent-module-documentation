#!/usr/bin/env bash
# Execution RESET: ensure content type sdt_range_eval + daterange field field_sdtr_conf exist,
# with field_sdtr_conf already using single_date_time_range_widget but at the DEFAULT hour_format
# (24h). verify FAILs until the agent reconfigures the widget to 12-hour format. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("sdt_range_eval")) {
    NodeType::create(["type" => "sdt_range_eval", "name" => "SDT Range Eval"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_sdtr_conf")) {
    FieldStorageConfig::create([
      "field_name" => "field_sdtr_conf", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "sdt_range_eval", "field_sdtr_conf")) {
    FieldConfig::create([
      "field_name" => "field_sdtr_conf", "entity_type" => "node",
      "bundle" => "sdt_range_eval", "label" => "Campaign Period",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "sdt_range_eval", "default");
  $fd->setComponent("field_sdtr_conf", ["type" => "single_date_time_range_widget", "weight" => 20, "region" => "content", "settings" => ["hour_format" => "24h"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_sdtr_conf uses single_date_time_range_widget hour_format=24h"
