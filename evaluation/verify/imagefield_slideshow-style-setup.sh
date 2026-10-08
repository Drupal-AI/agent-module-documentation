#!/usr/bin/env bash
# Introspection SETUP: add image field field_ifs_promo to Article, slideshow formatter with
# image style 'thumbnail'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ifs_promo")) {
    FieldStorageConfig::create(["field_name"=>"field_ifs_promo","entity_type"=>"node","type"=>"image","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ifs_promo")) {
    FieldConfig::create(["field_name"=>"field_ifs_promo","entity_type"=>"node","bundle"=>"article","label"=>"IFS Promo"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_ifs_promo", [
    "type"=>"imagefield_slideshow_field_formatter","label"=>"hidden","region"=>"content","weight"=>51,
    "settings"=>["imagefield_slideshow_style"=>"thumbnail","imagefield_slideshow_style_effects"=>"fade"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ifs_promo slideshow image style=thumbnail"
