#!/usr/bin/env bash
# Introspection SETUP: create image field field_ic_known on Article and set an image_class CSS
# class on its Image formatter (default view mode), so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ic_known")) {
    FieldStorageConfig::create(["field_name"=>"field_ic_known","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ic_known")) {
    FieldConfig::create(["field_name"=>"field_ic_known","entity_type"=>"node","bundle"=>"article","label"=>"IC Known Image"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ic_known", [
    "type"=>"image","label"=>"hidden","weight"=>50,"region"=>"content",
    "settings"=>["image_style"=>"","image_link"=>""],
    "third_party_settings"=>["image_class"=>["class"=>"ic-rounded ic-shadow"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ic_known (image) has image_class.class=\"ic-rounded ic-shadow\""
