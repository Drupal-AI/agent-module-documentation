#!/usr/bin/env bash
# Introspection SETUP: put two Date range fields on Article - field_tr_which using the
# time_range widget and field_tr_other using the core daterange_default widget - so an agent
# must inspect the form display to see which one uses Time Range. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["field_tr_which","field_tr_other"] as $fn) {
    if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node",$fn)) {
      \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"daterange","settings"=>["datetime_type"=>"datetime"]])->save();
    }
    if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article",$fn)) {
      \Drupal\field\Entity\FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>$fn])->save();
    }
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_tr_which",["type"=>"time_range","weight"=>50,"region"=>"content","settings"=>["start_label"=>"Start time","end_label"=>"End time"]]);
  $fd->setComponent("field_tr_other",["type"=>"daterange_default","weight"=>51,"region"=>"content"]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tr_which=time_range, field_tr_other=daterange_default on node.article"
