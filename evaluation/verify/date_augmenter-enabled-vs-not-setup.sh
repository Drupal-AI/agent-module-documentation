#!/usr/bin/env bash
# Introspection SETUP: two datetime fields on Article; field_da_on has date_augmenter settings on
# its view-display formatter, field_da_off does not. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_da_on","field_da_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save();
    }
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_da_on", [
    "type"=>"datetime_default","label"=>"above","weight"=>51,"region"=>"content",
    "third_party_settings"=>["date_augmenter"=>["instances"=>["status"=>["add_to_calendar"=>true]]]],
  ]);
  $vd->setComponent("field_da_off", ["type"=>"datetime_default","label"=>"above","weight"=>52,"region"=>"content"]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_da_on (augmented) + field_da_off (plain) on node.article.default view display"
