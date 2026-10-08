#!/usr/bin/env bash
# Execution RESET: attach the field_images image field to Article shown with the plain 'image' formatter,
# so verify FAILS until the agent switches it to the Splide (splide_image) formatter using the x_carousel
# optionset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_images")) {
    FieldStorageConfig::create(["field_name"=>"field_images","entity_type"=>"node","type"=>"image","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_images")) {
    FieldConfig::create(["field_name"=>"field_images","entity_type"=>"node","bundle"=>"article","label"=>"Images"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_images", ["type"=>"image","label"=>"hidden","weight"=>70,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_images shown with plain image formatter"
