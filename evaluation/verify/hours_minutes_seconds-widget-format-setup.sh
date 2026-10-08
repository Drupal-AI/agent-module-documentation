#!/usr/bin/env bash
# Introspection SETUP (hours_minutes_seconds): create field_hms_fmt on Article and set its widget
# input format to a known value on the default form display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_hms_fmt")) {
    FieldStorageConfig::create(["field_name"=>"field_hms_fmt","entity_type"=>"node","type"=>"hour_minutes_seconds"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_hms_fmt")) {
    FieldConfig::create(["field_name"=>"field_hms_fmt","entity_type"=>"node","bundle"=>"article","label"=>"Fmt Duration"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_hms_fmt", [
    "type"=>"hour_minutes_seconds_default","weight"=>50,"region"=>"content",
    "settings"=>["format"=>"d:h:mm:ss","default_placeholder"=>TRUE,"placeholder"=>"","show_seconds_hint"=>FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_hms_fmt widget input format = d:h:mm:ss"
