#!/usr/bin/env bash
# Introspection SETUP (hours_minutes_seconds): create an HMS field field_hms_known on Article with
# known min/max instance settings (seconds) so an agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_hms_known")) {
    FieldStorageConfig::create(["field_name"=>"field_hms_known","entity_type"=>"node","type"=>"hour_minutes_seconds"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_hms_known")) {
    FieldConfig::create(["field_name"=>"field_hms_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Duration","settings"=>["min"=>"60","max"=>"3600"]])->save();
  } else {
    $fc = FieldConfig::loadByName("node","article","field_hms_known");
    $fc->setSetting("min","60")->setSetting("max","3600")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_hms_known (hour_minutes_seconds) min=60 max=3600"
