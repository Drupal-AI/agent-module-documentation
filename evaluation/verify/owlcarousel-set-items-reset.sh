#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_owl_pic")) { FieldStorageConfig::create(["field_name"=>"field_owl_pic","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_owl_pic")) { FieldConfig::create(["field_name"=>"field_owl_pic","entity_type"=>"node","bundle"=>"article","label"=>"Owl Pic"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_owl_pic", ["type"=>"image","label"=>"hidden","weight"=>71,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_owl_pic uses plain image formatter"
