#!/usr/bin/env bash
# Execution RESET: image field on Article shown with the plain core image formatter, so verify
# FAILS until switched to responsive_image_class with the class.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ecfri_pic")) { FieldStorageConfig::create(["field_name"=>"field_ecfri_pic","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ecfri_pic")) { FieldConfig::create(["field_name"=>"field_ecfri_pic","entity_type"=>"node","bundle"=>"article","label"=>"ECFRI Pic"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_ecfri_pic", ["type"=>"image","label"=>"hidden","weight"=>61,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_ecfri_pic uses plain image formatter"
