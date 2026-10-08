#!/usr/bin/env bash
# Introspection SETUP: image field on Article displayed as an Owl Carousel with known options.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_owl_img")) { FieldStorageConfig::create(["field_name"=>"field_owl_img","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_owl_img")) { FieldConfig::create(["field_name"=>"field_owl_img","entity_type"=>"node","bundle"=>"article","label"=>"Owl Img"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_owl_img", ["type"=>"owlcarousel_field_formatter","label"=>"hidden","weight"=>70,"region"=>"content","settings"=>["items"=>4,"margin"=>20,"loop"=>true,"nav"=>true,"dots"=>true]])->save();
' >/dev/null 2>&1
echo "setup: field_owl_img owlcarousel items=4 margin=20 loop=1 nav=1"
