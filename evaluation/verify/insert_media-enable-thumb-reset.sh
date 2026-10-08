#!/usr/bin/env bash
# Execution RESET (insert_media): ensure a media entity_reference field field_insert_mtask2 exists
# on Article with the media_library_widget and Insert Media DISABLED (empty view_modes), so verify
# FAILS until the agent enables the 'thumbnail' insert view mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_insert_mtask2")) {
    FieldStorageConfig::create(["field_name" => "field_insert_mtask2", "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "media"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_mtask2")) {
    FieldConfig::create(["field_name" => "field_insert_mtask2", "entity_type" => "node", "bundle" => "article", "label" => "Task Media 2", "settings" => ["handler" => "default:media"]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_insert_mtask2", [
    "type" => "media_library_widget", "weight" => 65, "region" => "content",
    "third_party_settings" => ["insert_media" => ["view_modes" => [], "default" => "full"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_insert_mtask2 media_library_widget with insert_media disabled (no view modes)"
