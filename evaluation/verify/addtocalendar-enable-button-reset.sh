#!/usr/bin/env bash
# Execution RESET: ensure a datetime field field_atc_task exists on Article on the default view
# display with a datetime_default formatter and the addtocalendar button OFF, so verify FAILS
# until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_atc_task", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_atc_task")) {
    FieldConfig::create([
      "field_name" => "field_atc_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Session Date",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_atc_task", [
    "type" => "datetime_default", "weight" => 50, "region" => "content", "label" => "above",
    "settings" => [], "third_party_settings" => ["addtocalendar" => ["addtocalendar_show" => 0]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_atc_task datetime present with addtocalendar_show=0"
