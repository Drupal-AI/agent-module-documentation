#!/usr/bin/env bash
# Introspection SETUP: image field on Article shown via responsive_image_class with a known class.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ecfri_img")) { FieldStorageConfig::create(["field_name"=>"field_ecfri_img","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ecfri_img")) { FieldConfig::create(["field_name"=>"field_ecfri_img","entity_type"=>"node","bundle"=>"article","label"=>"ECFRI Img"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_ecfri_img", ["type"=>"responsive_image_class","label"=>"hidden","weight"=>60,"region"=>"content","settings"=>["class"=>"rounded"]])->save();
' >/dev/null 2>&1
echo "setup: field_ecfri_img uses responsive_image_class class=rounded"
