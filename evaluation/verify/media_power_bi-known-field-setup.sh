#!/usr/bin/env bash
# Introspection SETUP: create a media type mpb_gov using the Media Power BI source with a
# namespaced source field field_mpb_gov, so an agent can inspect the source field's type.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("media", "field_mpb_gov")) {
    FieldStorageConfig::create(["field_name" => "field_mpb_gov", "entity_type" => "media", "type" => "string_long"])->save();
  }
  if (!MediaType::load("mpb_gov")) {
    MediaType::create([
      "id" => "mpb_gov", "label" => "MPB Gov", "source" => "media_power_bi",
      "source_configuration" => ["source_field" => "field_mpb_gov"],
    ])->save();
  }
  if (!FieldConfig::loadByName("media", "mpb_gov", "field_mpb_gov")) {
    FieldConfig::create(["field_name" => "field_mpb_gov", "entity_type" => "media", "bundle" => "mpb_gov", "label" => "Gov URL"])->save();
  }
' >/dev/null 2>&1
echo "setup: media type mpb_gov source_field field_mpb_gov (string_long)"
