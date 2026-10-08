#!/usr/bin/env bash
# Introspection SETUP: add a string field field_faip_known to Article and set its default
# form-display widget to the Font Awesome Icon Picker, so an inspecting agent can find which
# field uses that widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_faip_known")) {
    FieldStorageConfig::create(["field_name"=>"field_faip_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_faip_known")) {
    FieldConfig::create(["field_name"=>"field_faip_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Icon"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_faip_known",["type"=>"fontawesome_iconpicker","weight"=>50,"region"=>"content","settings"=>["type"=>"default","size"=>60,"placeholder"=>""]])->save();
' >/dev/null 2>&1
echo "setup: node.article field_faip_known uses the fontawesome_iconpicker widget"
