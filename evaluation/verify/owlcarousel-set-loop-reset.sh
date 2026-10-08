#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_owl_slide")) { FieldStorageConfig::create(["field_name"=>"field_owl_slide","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_owl_slide")) { FieldConfig::create(["field_name"=>"field_owl_slide","entity_type"=>"node","bundle"=>"article","label"=>"Owl Slide"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_owl_slide", ["type"=>"image","label"=>"hidden","weight"=>72,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_owl_slide uses plain image formatter"
