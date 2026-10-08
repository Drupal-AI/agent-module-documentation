#!/usr/bin/env bash
# Introspection SETUP: create content type single_datetime_eval with TWO datetime fields —
# field_sdt_on using the Single DateTimePicker widget (single_date_time_widget) and field_sdt_off
# using core's datetime_default — so the agent must inspect the live form display to say which
# field uses the picker. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("single_datetime_eval")) {
    NodeType::create(["type" => "single_datetime_eval", "name" => "Single Datetime Eval"])->save();
  }
  foreach (["field_sdt_on" => "Picker Date", "field_sdt_off" => "Plain Date"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "single_datetime_eval", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "bundle" => "single_datetime_eval", "label" => $label,
      ])->save();
    }
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.single_datetime_eval.default")
    ?: $s->create(["targetEntityType" => "node", "bundle" => "single_datetime_eval", "mode" => "default", "status" => TRUE]);
  $fd->setComponent("field_sdt_on", ["type" => "single_date_time_widget", "weight" => 20, "region" => "content", "settings" => []]);
  $fd->setComponent("field_sdt_off", ["type" => "datetime_default", "weight" => 21, "region" => "content", "settings" => []]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_sdt_on=single_date_time_widget, field_sdt_off=datetime_default"
