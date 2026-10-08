#!/usr/bin/env bash
# Introspection SETUP: two image fields on Article; only field_ic_on carries an image_class class.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ic_on","field_ic_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"image"])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save();
    }
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ic_on", ["type"=>"image","label"=>"hidden","weight"=>51,"region"=>"content","settings"=>["image_style"=>"","image_link"=>""],"third_party_settings"=>["image_class"=>["class"=>"ic-hero"]]]);
  $vd->setComponent("field_ic_off", ["type"=>"image","label"=>"hidden","weight"=>52,"region"=>"content","settings"=>["image_style"=>"","image_link"=>""],"third_party_settings"=>[]]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ic_on has image_class.class=ic-hero; field_ic_off has none"
