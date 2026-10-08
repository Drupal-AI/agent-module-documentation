#!/usr/bin/env bash
# Introspection SETUP: add string field field_faip_size to Article and set its default
# view-display formatter to the Font Awesome Icon Picker at size fa-4x, so an inspecting agent
# can read the configured icon size. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_faip_size")) {
    FieldStorageConfig::create(["field_name"=>"field_faip_size","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_faip_size")) {
    FieldConfig::create(["field_name"=>"field_faip_size","entity_type"=>"node","bundle"=>"article","label"=>"Sized Icon"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_faip_size",["type"=>"fontawesome_iconpicker_formatter_type","weight"=>50,"region"=>"content","settings"=>["size"=>"fa-4x"]])->save();
' >/dev/null 2>&1
echo "setup: node.article field_faip_size formatter size=fa-4x"
