#!/usr/bin/env bash
# Introspection SETUP: create image field field_diw_known on Article (alt enabled, NOT
# required), image_image widget, and enable decorative_image_widget use_decorative_checkbox on
# its form-display component. Uses a two-save pattern so lightning_media_image (which rewrites
# NEW image components to its entity_browser image widget) leaves the image_image widget in
# place on the second save. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_diw_known")) {
    FieldStorageConfig::create(["field_name"=>"field_diw_known","entity_type"=>"node","type"=>"image"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_diw_known")) {
    FieldConfig::create(["field_name"=>"field_diw_known","entity_type"=>"node","bundle"=>"article","label"=>"DIW Known Image","settings"=>["alt_field"=>TRUE,"alt_field_required"=>FALSE]])->save();
  }
  $s=\Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd=$s->load("node.article.default");
  $fd->setComponent("field_diw_known",["type"=>"image_image","weight"=>60,"region"=>"content","settings"=>[]]);
  $fd->save();
  $fd=$s->loadUnchanged("node.article.default");
  $fd->setComponent("field_diw_known",["type"=>"image_image","weight"=>60,"region"=>"content","settings"=>[],"third_party_settings"=>["decorative_image_widget"=>["use_decorative_checkbox"=>TRUE]]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_diw_known (image_image) has decorative_image_widget.use_decorative_checkbox=true"
