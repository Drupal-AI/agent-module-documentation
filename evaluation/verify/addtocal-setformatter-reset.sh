#!/usr/bin/env bash
# Execution RESET: ensure field_atc_task exists with a NON-addtocal formatter (datetime_default)
# so verify fails until the agent switches it to addtocal_view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_task")) {
    FieldStorageConfig::create(["field_name"=>"field_atc_task","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_atc_task")) {
    FieldConfig::create(["field_name"=>"field_atc_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Event Date"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_atc_task", ["type"=>"datetime_default","label"=>"above","weight"=>63,"region"=>"content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_atc_task uses datetime_default (not addtocal)"
