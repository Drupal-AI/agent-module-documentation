#!/usr/bin/env bash
# Execution RESET: field_atc_title exists with datetime_default (verify fails until agent sets
# addtocal_view + event_title). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_title")) {
    FieldStorageConfig::create(["field_name"=>"field_atc_title","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_atc_title")) {
    FieldConfig::create(["field_name"=>"field_atc_title","entity_type"=>"node","bundle"=>"article","label"=>"Titled Event Date"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_atc_title", ["type"=>"datetime_default","label"=>"above","weight"=>64,"region"=>"content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_atc_title uses datetime_default"
