#!/usr/bin/env bash
# Introspection SETUP: add a multi-value image field field_ifs_gallery to Article and set its
# default view-display formatter to the slideshow with the scrollHorz effect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ifs_gallery")) {
    FieldStorageConfig::create(["field_name"=>"field_ifs_gallery","entity_type"=>"node","type"=>"image","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ifs_gallery")) {
    FieldConfig::create(["field_name"=>"field_ifs_gallery","entity_type"=>"node","bundle"=>"article","label"=>"IFS Gallery"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_ifs_gallery", [
    "type"=>"imagefield_slideshow_field_formatter","label"=>"hidden","region"=>"content","weight"=>50,
    "settings"=>["imagefield_slideshow_style"=>"large","imagefield_slideshow_style_effects"=>"scrollHorz","imagefield_slideshow_timeout"=>3000],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ifs_gallery slideshow effect=scrollHorz"
