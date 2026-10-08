#!/usr/bin/env bash
# Introspection SETUP: create link field field_micon_lka_med on Article using the micon_linkit_attributes widget. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_micon_lka_med")) {
    FieldStorageConfig::create(["field_name"=>"field_micon_lka_med","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_micon_lka_med")) {
    FieldConfig::create(["field_name"=>"field_micon_lka_med","entity_type"=>"node","bundle"=>"article","label"=>"Med Link"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_micon_lka_med", ["type"=>"micon_linkit_attributes","weight"=>54,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_micon_lka_med widget=micon_linkit_attributes"
