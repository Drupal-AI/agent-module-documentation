#!/usr/bin/env bash
# Introspection SETUP: create an image field field_fis_img and an image_style field
# field_fis_disp on Article, and configure the default view display so field_fis_img uses the
# Field Image Style formatter (image_style_image_formatter) reading its style from
# field_fis_disp. The agent must inspect the live display to report the source field.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fis_img")) {
    FieldStorageConfig::create(["field_name"=>"field_fis_img","entity_type"=>"node","type"=>"image","cardinality"=>1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fis_img")) {
    FieldConfig::create(["field_name"=>"field_fis_img","entity_type"=>"node","bundle"=>"article","label"=>"FIS Image"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_fis_disp")) {
    FieldStorageConfig::create(["field_name"=>"field_fis_disp","entity_type"=>"node","type"=>"image_style","cardinality"=>1,"settings"=>["allowed_values"=>[],"sort"=>FALSE]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fis_disp")) {
    FieldConfig::create(["field_name"=>"field_fis_disp","entity_type"=>"node","bundle"=>"article","label"=>"FIS Display Style"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fis_img", [
    "type" => "image_style_image_formatter", "weight" => 60, "region" => "content", "label" => "hidden",
    "settings" => ["field_image_style" => "field_fis_disp", "image_link" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_fis_img uses image_style_image_formatter reading field_fis_disp"
