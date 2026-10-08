#!/usr/bin/env bash
# Introspection SETUP: create two image fields on Article - field_diw_on with
# decorative_image_widget enabled and field_diw_off without it (both image_image) - so the
# agent must inspect the live form display to tell which one adds the Decorative checkbox.
# Two-save pattern keeps the image_image widget (vs lightning_media_image). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_diw_on"=>"DIW On Image","field_diw_off"=>"DIW Off Image"] as $fn=>$label) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"image"])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>$label,"settings"=>["alt_field"=>TRUE,"alt_field_required"=>FALSE]])->save();
    }
  }
  $s=\Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd=$s->load("node.article.default");
  $fd->setComponent("field_diw_on",["type"=>"image_image","weight"=>60,"region"=>"content","settings"=>[]]);
  $fd->setComponent("field_diw_off",["type"=>"image_image","weight"=>61,"region"=>"content","settings"=>[]]);
  $fd->save();
  $fd=$s->loadUnchanged("node.article.default");
  $fd->setComponent("field_diw_on",["type"=>"image_image","weight"=>60,"region"=>"content","settings"=>[],"third_party_settings"=>["decorative_image_widget"=>["use_decorative_checkbox"=>TRUE]]]);
  $fd->setComponent("field_diw_off",["type"=>"image_image","weight"=>61,"region"=>"content","settings"=>[],"third_party_settings"=>[]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_diw_on decorative=true, field_diw_off no decorative setting (both image_image)"
