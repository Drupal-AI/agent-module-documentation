#!/usr/bin/env bash
# Introspection SETUP: create image field field_mfp_gal on Article, render it with the
# magnific_popup formatter using gallery_type=first_item. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mfp_gal")) {
    FieldStorageConfig::create(["field_name"=>"field_mfp_gal","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mfp_gal")) {
    FieldConfig::create(["field_name"=>"field_mfp_gal","entity_type"=>"node","bundle"=>"article","label"=>"MFP Gallery"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_mfp_gal", ["type"=>"magnific_popup","region"=>"content","label"=>"hidden",
    "settings"=>["thumbnail_image_style"=>"","popup_image_style"=>"","gallery_type"=>"first_item","vertical_fit"=>"true"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_mfp_gal magnific_popup gallery_type=first_item"
