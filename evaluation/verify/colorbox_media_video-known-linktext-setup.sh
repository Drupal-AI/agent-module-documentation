#!/usr/bin/env bash
# Introspection SETUP: create string field field_cmv_video on Article and display it with the
# colorbox_media_remote_video formatter in text mode with a known link_text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_cmv_video")) {
    FieldStorageConfig::create(["field_name"=>"field_cmv_video","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_cmv_video")) {
    FieldConfig::create(["field_name"=>"field_cmv_video","entity_type"=>"node","bundle"=>"article","label"=>"CMV Video URL"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_cmv_video", [
    "type"=>"colorbox_media_remote_video","label"=>"hidden","weight"=>50,"region"=>"content",
    "settings"=>["display"=>"text","link_text"=>"Watch the clip","image_style"=>"thumbnail","colorbox_gallery"=>"post","colorbox_gallery_custom"=>"","colorbox_caption"=>"auto","colorbox_caption_custom"=>""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_cmv_video colorbox_media_remote_video display=text link_text='Watch the clip'"
