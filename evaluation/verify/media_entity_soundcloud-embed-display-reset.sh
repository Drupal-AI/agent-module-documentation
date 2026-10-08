#!/usr/bin/env bash
# Execution RESET: create media type mes_embed (soundcloud) with source field field_mes_eurl and a
# default view display where that field uses the plain 'string' formatter (NOT soundcloud_embed),
# so verify FAILS until the agent switches it to soundcloud_embed/classic. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!MediaType::load("mes_embed")) {
    MediaType::create(["id" => "mes_embed", "label" => "MES Embed", "source" => "soundcloud"])->save();
  }
  if (!FieldStorageConfig::loadByName("media", "field_mes_eurl")) {
    FieldStorageConfig::create(["field_name" => "field_mes_eurl", "entity_type" => "media", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("media", "mes_embed", "field_mes_eurl")) {
    FieldConfig::create(["field_name" => "field_mes_eurl", "entity_type" => "media", "bundle" => "mes_embed", "label" => "SoundCloud URL"])->save();
  }
  MediaType::load("mes_embed")->set("source_configuration", ["source_field" => "field_mes_eurl"])->save();
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("media", "mes_embed", "default");
  $vd->setComponent("field_mes_eurl", ["type" => "string", "label" => "hidden", "region" => "content", "weight" => 0])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mes_embed field_mes_eurl formatter=string"
