#!/usr/bin/env bash
# Execution RESET: ensure field_cmv_grp exists on Article, displayed with the
# colorbox_media_remote_video formatter but colorbox_gallery=post (so verify, needing 'page',
# FAILS until the agent reconfigures). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_cmv_grp")) {
    FieldStorageConfig::create(["field_name"=>"field_cmv_grp","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_cmv_grp")) {
    FieldConfig::create(["field_name"=>"field_cmv_grp","entity_type"=>"node","bundle"=>"article","label"=>"CMV Group Video"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_cmv_grp", [
    "type"=>"colorbox_media_remote_video","label"=>"hidden","weight"=>53,"region"=>"content",
    "settings"=>["display"=>"thumbnail","link_text"=>"View Video","image_style"=>"thumbnail","colorbox_gallery"=>"post","colorbox_gallery_custom"=>"","colorbox_caption"=>"auto","colorbox_caption_custom"=>""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_cmv_grp colorbox_gallery=post"
