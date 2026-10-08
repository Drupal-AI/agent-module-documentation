#!/usr/bin/env bash
# Introspection SETUP: create a Media reference field on Article displayed with the
# file_download_link_media formatter and a distinctive link text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fdlm_probe")) {
    FieldStorageConfig::create(["field_name" => "field_fdlm_probe", "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "media"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fdlm_probe")) {
    FieldConfig::create(["field_name" => "field_fdlm_probe", "entity_type" => "node", "bundle" => "article", "label" => "FDLM Probe", "settings" => ["handler" => "default:media", "handler_settings" => []]])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fdlm_probe", [
    "type" => "file_download_link_media", "label" => "hidden", "weight" => 60, "region" => "content",
    "settings" => ["link_text" => "Media Grab", "new_tab" => true, "force_download" => true, "force_download_filename" => "", "custom_classes" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fdlm_probe uses file_download_link_media, link_text='Media Grab'"
