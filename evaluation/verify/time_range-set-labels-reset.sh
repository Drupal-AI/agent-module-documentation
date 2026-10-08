#!/usr/bin/env bash
# Execution RESET: ensure a Date range field field_tr_shift exists on Article using the
# time_range widget with the DEFAULT labels (Start time / End time), so verify FAILS until the
# agent renames them to Shift start / Shift end. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_tr_shift")) {
    \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>"field_tr_shift","entity_type"=>"node","type"=>"daterange","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_tr_shift")) {
    \Drupal\field\Entity\FieldConfig::create(["field_name"=>"field_tr_shift","entity_type"=>"node","bundle"=>"article","label"=>"Shift"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_tr_shift",["type"=>"time_range","weight"=>50,"region"=>"content","settings"=>["start_label"=>"Start time","end_label"=>"End time"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_tr_shift uses time_range with default labels"
