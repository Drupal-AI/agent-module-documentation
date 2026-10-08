#!/usr/bin/env bash
# Introspection SETUP: create TWO datetime fields on Article — field_dhs_on with
# datetimehideseconds "Hide seconds" ENABLED, and field_dhs_off with it NOT set — so the
# agent must inspect the live form display to tell which one hides seconds. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_dhs_on", "field_dhs_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article",
        "label" => ($fn === "field_dhs_on" ? "Start Time" : "End Time"),
      ])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dhs_on", [
    "type" => "datetime_default", "weight" => 50, "region" => "content",
    "third_party_settings" => ["datetimehideseconds" => ["hide" => TRUE]],
  ]);
  $fd->setComponent("field_dhs_off", [
    "type" => "datetime_default", "weight" => 51, "region" => "content",
    "third_party_settings" => [],
  ]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_dhs_on hide=true, field_dhs_off no hide setting (both datetime_default)"
