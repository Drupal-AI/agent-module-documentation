#!/usr/bin/env bash
# Introspection SETUP: create field_cmv_gallery on Article displayed with the
# colorbox_media_remote_video formatter using colorbox_gallery=page. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_cmv_gallery")) {
    FieldStorageConfig::create(["field_name"=>"field_cmv_gallery","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_cmv_gallery")) {
    FieldConfig::create(["field_name"=>"field_cmv_gallery","entity_type"=>"node","bundle"=>"article","label"=>"CMV Gallery Video"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_cmv_gallery", [
    "type"=>"colorbox_media_remote_video","label"=>"hidden","weight"=>51,"region"=>"content",
    "settings"=>["display"=>"thumbnail","link_text"=>"View Video","image_style"=>"thumbnail","colorbox_gallery"=>"page","colorbox_gallery_custom"=>"","colorbox_caption"=>"auto","colorbox_caption_custom"=>""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_cmv_gallery colorbox_gallery=page"
