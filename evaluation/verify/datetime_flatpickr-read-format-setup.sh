#!/usr/bin/env bash
# Introspection SETUP: datetime field field_dtf_known on Article with datetime_flatpickr
# widget, dateFormat d/m/Y. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_dtf_known")) { FieldStorageConfig::create(["field_name"=>"field_dtf_known","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save(); }
  if (!FieldConfig::loadByName("node","article","field_dtf_known")) { FieldConfig::create(["field_name"=>"field_dtf_known","entity_type"=>"node","bundle"=>"article","label"=>"DTF Known"])->save(); }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dtf_known", ["type"=>"datetime_flatpickr","weight"=>50,"region"=>"content","settings"=>["dateFormat"=>"d/m/Y","enableTime"=>TRUE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_dtf_known datetime_flatpickr dateFormat=d/m/Y"
