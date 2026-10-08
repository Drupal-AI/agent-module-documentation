#!/usr/bin/env bash
# Introspection SETUP (insert_media): create a media entity_reference field field_insert_media on
# Article with the media_library_widget and enable Insert Media on it (view_modes full+thumbnail,
# default full), so an agent can read back which field/view-mode has third_party_settings.insert_media.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_insert_media")) {
    FieldStorageConfig::create(["field_name" => "field_insert_media", "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "media"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_media")) {
    FieldConfig::create(["field_name" => "field_insert_media", "entity_type" => "node", "bundle" => "article", "label" => "Known Media", "settings" => ["handler" => "default:media"]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_insert_media", [
    "type" => "media_library_widget", "weight" => 62, "region" => "content",
    "third_party_settings" => ["insert_media" => ["view_modes" => ["full" => "full", "thumbnail" => "thumbnail"], "default" => "full"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_insert_media (media_library_widget) insert_media view_modes full,thumbnail default full"
