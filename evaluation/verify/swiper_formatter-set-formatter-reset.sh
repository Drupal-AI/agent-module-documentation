#!/usr/bin/env bash
# Execution RESET: ensure a text_long field field_sf_txt exists on Article and force its
# default view-display formatter to the plain 'text_default' (so verify FAILS until the agent
# switches it to swiper_formatter_text). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_sf_txt")) {
    FieldStorageConfig::create(["field_name"=>"field_sf_txt","entity_type"=>"node","type"=>"text_long","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_sf_txt")) {
    FieldConfig::create(["field_name"=>"field_sf_txt","entity_type"=>"node","bundle"=>"article","label"=>"SF Text"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sf_txt", ["type"=>"text_default","weight"=>60,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_sf_txt present with text_default formatter (needs swiper_formatter_text)"
