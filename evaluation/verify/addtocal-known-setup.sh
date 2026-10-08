#!/usr/bin/env bash
# Introspection SETUP: create a datetime field on Article and set its default display to the
# addtocal_view formatter with a known event_title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_known")) {
    FieldStorageConfig::create(["field_name"=>"field_atc_known","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_atc_known")) {
    FieldConfig::create(["field_name"=>"field_atc_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Event Date"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_atc_known", ["type"=>"addtocal_view","label"=>"hidden","weight"=>60,"region"=>"content","settings"=>["event_title"=>"ATC Probe Event","past_events"=>TRUE]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_atc_known uses addtocal_view with event_title=ATC Probe Event"
