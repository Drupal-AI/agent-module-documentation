#!/usr/bin/env bash
# Execution RESET: field_dtf_time with datetime_flatpickr widget but enableTime FALSE. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_dtf_time")) { FieldStorageConfig::create(["field_name"=>"field_dtf_time","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save(); }
  if (!FieldConfig::loadByName("node","article","field_dtf_time")) { FieldConfig::create(["field_name"=>"field_dtf_time","entity_type"=>"node","bundle"=>"article","label"=>"DTF Time"])->save(); }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dtf_time", ["type"=>"datetime_flatpickr","weight"=>50,"region"=>"content","settings"=>["enableTime"=>FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_dtf_time datetime_flatpickr enableTime=FALSE"
