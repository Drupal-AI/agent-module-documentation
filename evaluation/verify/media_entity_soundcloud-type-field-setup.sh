#!/usr/bin/env bash
# Introspection SETUP: create a SoundCloud media type mes_intro with a known source field
# (field_mes_iurl) so the agent can inspect the media type and report its source field name.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!MediaType::load("mes_intro")) {
    MediaType::create(["id" => "mes_intro", "label" => "MES Intro", "source" => "soundcloud"])->save();
  }
  if (!FieldStorageConfig::loadByName("media", "field_mes_iurl")) {
    FieldStorageConfig::create(["field_name" => "field_mes_iurl", "entity_type" => "media", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("media", "mes_intro", "field_mes_iurl")) {
    FieldConfig::create(["field_name" => "field_mes_iurl", "entity_type" => "media", "bundle" => "mes_intro", "label" => "SoundCloud URL"])->save();
  }
  MediaType::load("mes_intro")->set("source_configuration", ["source_field" => "field_mes_iurl"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mes_intro (soundcloud) source_field=field_mes_iurl"
