#!/usr/bin/env bash
# Execution RESET: ensure an image field field_fis_wimg and image_style field field_fis_wsrc
# exist on Article, and force field_fis_wimg's default-display formatter to the plain core
# 'image' formatter (NOT the Field Image Style formatter), so verify FAILS until the agent
# switches it to image_style_image_formatter reading field_fis_wsrc. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fis_wimg")) {
    FieldStorageConfig::create(["field_name"=>"field_fis_wimg","entity_type"=>"node","type"=>"image","cardinality"=>1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fis_wimg")) {
    FieldConfig::create(["field_name"=>"field_fis_wimg","entity_type"=>"node","bundle"=>"article","label"=>"FIS Wire Image"])->save();
  }
  if (!FieldStorageConfig::loadByName("node","field_fis_wsrc")) {
    FieldStorageConfig::create(["field_name"=>"field_fis_wsrc","entity_type"=>"node","type"=>"image_style","cardinality"=>1,"settings"=>["allowed_values"=>[],"sort"=>FALSE]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fis_wsrc")) {
    FieldConfig::create(["field_name"=>"field_fis_wsrc","entity_type"=>"node","bundle"=>"article","label"=>"FIS Wire Style"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fis_wimg", [
    "type" => "image", "weight" => 61, "region" => "content", "label" => "hidden",
    "settings" => ["image_style" => "", "image_link" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fis_wimg uses plain core image formatter"
