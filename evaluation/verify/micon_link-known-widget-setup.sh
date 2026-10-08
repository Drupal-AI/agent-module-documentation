#!/usr/bin/env bash
# Introspection SETUP: create link field field_micon_link_med on Article using the micon_link
# widget with a default fallback icon (fa-star). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_micon_link_med")) {
    FieldStorageConfig::create(["field_name"=>"field_micon_link_med","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_micon_link_med")) {
    FieldConfig::create(["field_name"=>"field_micon_link_med","entity_type"=>"node","bundle"=>"article","label"=>"Med Link"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_micon_link_med", ["type"=>"micon_link","weight"=>52,"region"=>"content","settings"=>["packages"=>[],"icon"=>"fa-star","position"=>FALSE,"target"=>FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_micon_link_med widget=micon_link default icon=fa-star"
