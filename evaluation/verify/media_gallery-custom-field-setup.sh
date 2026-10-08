#!/usr/bin/env bash
# Introspection SETUP: attach a namespaced string field (field_mg_note) to the media_gallery
# bundle via the entity's field_ui_base_route capability, so an agent can read back which
# custom field exists on galleries. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("media_gallery", "field_mg_note")) {
    FieldStorageConfig::create(["field_name" => "field_mg_note", "entity_type" => "media_gallery", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("media_gallery", "media_gallery", "field_mg_note")) {
    FieldConfig::create(["field_name" => "field_mg_note", "entity_type" => "media_gallery", "bundle" => "media_gallery", "label" => "Curator note"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_mg_note attached to media_gallery bundle"
