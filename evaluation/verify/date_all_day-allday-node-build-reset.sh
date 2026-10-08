#!/usr/bin/env bash
# Execution RESET: ensure the daterange field field_dad_build exists on Article with the
# date_all_day widget, and delete any node titled "DAD Build All Day" so verify FAILS until the
# agent creates one whose stored range really is an all-day range. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dad_build")) {
    FieldStorageConfig::create([
      "field_name" => "field_dad_build", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dad_build")) {
    FieldConfig::create([
      "field_name" => "field_dad_build", "entity_type" => "node",
      "bundle" => "article", "label" => "DAD Build Dates",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dad_build", [
    "type" => "daterange_all_day", "weight" => 73, "region" => "content",
    "settings" => [], "third_party_settings" => [],
  ])->save();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "DAD Build All Day"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_dad_build present (daterange_all_day widget); node 'DAD Build All Day' absent"
