#!/usr/bin/env bash
# Execution RESET: ensure a daterange field field_dad_task exists on Article and force BOTH its
# default form-display widget and its default view-display formatter back to core's plain
# datetime_range plugins, so verify FAILS until the agent switches them to the date_all_day
# widget and formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dad_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_dad_task", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dad_task")) {
    FieldConfig::create([
      "field_name" => "field_dad_task", "entity_type" => "node",
      "bundle" => "article", "label" => "DAD Task Event Dates",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dad_task", [
    "type" => "daterange_default", "weight" => 72, "region" => "content",
    "settings" => [], "third_party_settings" => [],
  ])->save();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_dad_task", [
    "type" => "daterange_default", "label" => "above", "weight" => 72, "region" => "content",
    "settings" => ["timezone_override" => "", "format_type" => "medium", "separator" => "-"],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_dad_task uses core daterange_default widget and formatter"
