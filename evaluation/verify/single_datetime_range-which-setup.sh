#!/usr/bin/env bash
# Introspection SETUP: create content type sdt_range_eval with TWO daterange fields —
# field_sdtr_on using the Single DateTimePicker range widget (single_date_time_range_widget)
# and field_sdtr_off using core's daterange_default widget — so the agent must inspect the live
# form display to say which daterange field uses the picker. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("sdt_range_eval")) {
    NodeType::create(["type" => "sdt_range_eval", "name" => "SDT Range Eval"])->save();
  }
  foreach (["field_sdtr_on" => "Picker Period", "field_sdtr_off" => "Plain Period"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "sdt_range_eval", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "bundle" => "sdt_range_eval", "label" => $label,
      ])->save();
    }
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "sdt_range_eval", "default");
  $fd->setComponent("field_sdtr_on", ["type" => "single_date_time_range_widget", "weight" => 20, "region" => "content", "settings" => []]);
  $fd->setComponent("field_sdtr_off", ["type" => "daterange_default", "weight" => 21, "region" => "content", "settings" => []]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_sdtr_on=single_date_time_range_widget, field_sdtr_off=daterange_default"
