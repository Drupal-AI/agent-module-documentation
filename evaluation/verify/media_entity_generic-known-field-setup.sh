#!/usr/bin/env bash
# Introspection SETUP: media type meg_field using 'generic' source whose source field is the
# string field field_meg_code. Agent reads back the source field machine name. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!MediaType::load("meg_field")) {
    MediaType::create(["id" => "meg_field", "label" => "MEG Field", "source" => "generic"])->save();
  }
  if (!FieldStorageConfig::loadByName("media", "field_meg_code")) {
    FieldStorageConfig::create(["field_name" => "field_meg_code", "entity_type" => "media", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("media", "meg_field", "field_meg_code")) {
    FieldConfig::create(["field_name" => "field_meg_code", "entity_type" => "media", "bundle" => "meg_field", "label" => "Code"])->save();
  }
  MediaType::load("meg_field")->set("source_configuration", ["source_field" => "field_meg_code"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type meg_field (generic) source_field=field_meg_code"
