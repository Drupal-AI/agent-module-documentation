#!/usr/bin/env bash
# Execution RESET: ensure a datetime field field_dhs_task exists on Article with a
# datetime_default widget on the default form display, and force datetimehideseconds
# "Hide seconds" OFF (so verify FAILS until the agent enables it). Creates the field if
# missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dhs_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_dhs_task", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dhs_task")) {
    FieldConfig::create([
      "field_name" => "field_dhs_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Deadline",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dhs_task", [
    "type" => "datetime_default", "weight" => 50, "region" => "content",
    "third_party_settings" => ["datetimehideseconds" => ["hide" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_dhs_task present with datetimehideseconds.hide=FALSE"
