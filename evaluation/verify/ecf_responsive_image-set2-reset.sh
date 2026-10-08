#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ecfri_ph")) { FieldStorageConfig::create(["field_name"=>"field_ecfri_ph","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ecfri_ph")) { FieldConfig::create(["field_name"=>"field_ecfri_ph","entity_type"=>"node","bundle"=>"article","label"=>"ECFRI Ph"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_ecfri_ph", ["type"=>"image","label"=>"hidden","weight"=>62,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_ecfri_ph uses plain image formatter"
