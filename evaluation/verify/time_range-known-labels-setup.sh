#!/usr/bin/env bash
# Introspection SETUP: create a Date range (daterange) field field_tr_known on Article using
# the time_range widget with custom labels Opens/Closes on the default form display, so an
# agent can read the labels back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_tr_known")) {
    \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>"field_tr_known","entity_type"=>"node","type"=>"daterange","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_tr_known")) {
    \Drupal\field\Entity\FieldConfig::create(["field_name"=>"field_tr_known","entity_type"=>"node","bundle"=>"article","label"=>"Business hours"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_tr_known",["type"=>"time_range","weight"=>50,"region"=>"content","settings"=>["start_label"=>"Opens","end_label"=>"Closes"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_tr_known uses time_range widget with labels Opens/Closes"
