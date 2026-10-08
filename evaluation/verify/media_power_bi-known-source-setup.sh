#!/usr/bin/env bash
# Introspection SETUP: create a media type mpb_powerbi that uses the Media Power BI source
# (media_power_bi) with a namespaced string_long source field field_mpb_pbi, so an agent can
# read back which source plugin the media type uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("media", "field_mpb_pbi")) {
    FieldStorageConfig::create(["field_name" => "field_mpb_pbi", "entity_type" => "media", "type" => "string_long"])->save();
  }
  if (!MediaType::load("mpb_powerbi")) {
    MediaType::create([
      "id" => "mpb_powerbi", "label" => "MPB Power BI", "source" => "media_power_bi",
      "source_configuration" => ["source_field" => "field_mpb_pbi"],
    ])->save();
  }
  if (!FieldConfig::loadByName("media", "mpb_powerbi", "field_mpb_pbi")) {
    FieldConfig::create(["field_name" => "field_mpb_pbi", "entity_type" => "media", "bundle" => "mpb_powerbi", "label" => "Power BI URL"])->save();
  }
' >/dev/null 2>&1
echo "setup: media type mpb_powerbi uses source media_power_bi (field_mpb_pbi)"
