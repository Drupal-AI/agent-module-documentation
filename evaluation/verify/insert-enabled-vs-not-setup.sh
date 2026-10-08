#!/usr/bin/env bash
# Introspection SETUP: two FILE fields on Article, field_insert_on (Insert enabled: styles=link)
# and field_insert_off (Insert present but styles empty => disabled). Agent must say which one has
# Insert enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_insert_on" => "Insert On", "field_insert_off" => "Insert Off"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "file"])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create(["field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => $label])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_insert_on", [
    "type" => "file_generic", "weight" => 60, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => ["link" => "link"], "default" => "insert__auto"]],
  ]);
  $fd->setComponent("field_insert_off", [
    "type" => "file_generic", "weight" => 61, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => [], "default" => "insert__auto"]],
  ]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_insert_on (styles=[link]) enabled, field_insert_off (styles=[]) disabled"
