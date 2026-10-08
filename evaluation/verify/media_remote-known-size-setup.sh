#!/usr/bin/env bash
# Introspection SETUP: create a Remote Media type "mr_size" whose default display renders the
# source field field_mr_size with the Google provider formatter at a NON-DEFAULT iframe size
# (1280x720 instead of the formatter default 960x600), so the agent must read the live formatter
# settings rather than recite defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if (!MediaType::load("mr_size")) {
    MediaType::create(["id" => "mr_size", "label" => "MR Size", "source" => "media_remote"])->save();
  }
  if (!FieldStorageConfig::loadByName("media", "field_mr_size")) {
    FieldStorageConfig::create([
      "field_name" => "field_mr_size", "entity_type" => "media", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("media", "mr_size", "field_mr_size")) {
    FieldConfig::create([
      "field_name" => "field_mr_size", "entity_type" => "media",
      "bundle" => "mr_size", "label" => "Remote URL", "required" => TRUE,
    ])->save();
  }
  $t = MediaType::load("mr_size");
  $t->set("source_configuration", ["source_field" => "field_mr_size"])->save();
  $d = EntityViewDisplay::load("media.mr_size.default") ?: EntityViewDisplay::create([
    "targetEntityType" => "media", "bundle" => "mr_size", "mode" => "default", "status" => TRUE,
  ]);
  $d->setComponent("field_mr_size", [
    "type" => "media_remote_google", "label" => "hidden", "weight" => 0, "region" => "content",
    "settings" => [
      "formatter_class" => "Drupal\\media_remote\\Plugin\\Field\\FieldFormatter\\MediaRemoteGoogleFormatter",
      "width" => 1280, "height" => 720,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mr_size uses media_remote_google at 1280x720"
