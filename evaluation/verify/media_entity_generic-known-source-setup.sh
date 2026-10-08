#!/usr/bin/env bash
# Introspection SETUP: create media type meg_known using the 'generic' media source, with a
# string source field. Agent reads back the source plugin id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!MediaType::load("meg_known")) {
    MediaType::create(["id" => "meg_known", "label" => "MEG Known", "source" => "generic"])->save();
  }
  if (!FieldStorageConfig::loadByName("media", "field_meg_known")) {
    FieldStorageConfig::create(["field_name" => "field_meg_known", "entity_type" => "media", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("media", "meg_known", "field_meg_known")) {
    FieldConfig::create(["field_name" => "field_meg_known", "entity_type" => "media", "bundle" => "meg_known", "label" => "Value"])->save();
  }
  MediaType::load("meg_known")->set("source_configuration", ["source_field" => "field_meg_known"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type meg_known uses source generic (field_meg_known)"
