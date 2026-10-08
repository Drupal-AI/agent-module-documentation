#!/usr/bin/env bash
# Introspection SETUP: create a text_long field field_sf_txt on Article and set the default
# view display to render it with the swiper_formatter_text formatter using the sf_known
# template. The agent must read the live entity_view_display to name the formatter. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\swiper_formatter\Entity\SwiperFormatter;
  if (!SwiperFormatter::load("sf_known")) {
    SwiperFormatter::create(["id"=>"sf_known","label"=>"SF Known"])->save();
  }
  if (!FieldStorageConfig::loadByName("node","field_sf_txt")) {
    FieldStorageConfig::create(["field_name"=>"field_sf_txt","entity_type"=>"node","type"=>"text_long","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_sf_txt")) {
    FieldConfig::create(["field_name"=>"field_sf_txt","entity_type"=>"node","bundle"=>"article","label"=>"SF Text"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sf_txt", ["type"=>"swiper_formatter_text","weight"=>60,"region"=>"content","settings"=>["template"=>"sf_known"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_sf_txt rendered with swiper_formatter_text (template sf_known)"
