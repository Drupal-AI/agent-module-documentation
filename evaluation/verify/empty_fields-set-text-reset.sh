#!/usr/bin/env bash
# Execution RESET: ensure field_ef exists on Article and its default display component has NO
# empty_fields handler, so verify FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ef")) {
    FieldStorageConfig::create(["field_name"=>"field_ef","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ef")) {
    FieldConfig::create(["field_name"=>"field_ef","entity_type"=>"node","bundle"=>"article","label"=>"EF"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ef", ["type"=>"string","region"=>"content","label"=>"above","settings"=>[],"third_party_settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ef present, no empty_fields handler"
