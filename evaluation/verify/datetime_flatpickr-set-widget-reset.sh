#!/usr/bin/env bash
# Execution RESET: field_dtf_task datetime field with datetime_default widget (so verify FAILS
# until agent switches to flatpickr). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_dtf_task")) { FieldStorageConfig::create(["field_name"=>"field_dtf_task","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save(); }
  if (!FieldConfig::loadByName("node","article","field_dtf_task")) { FieldConfig::create(["field_name"=>"field_dtf_task","entity_type"=>"node","bundle"=>"article","label"=>"DTF Task"])->save(); }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dtf_task", ["type"=>"datetime_default","weight"=>50,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_dtf_task widget=datetime_default"
