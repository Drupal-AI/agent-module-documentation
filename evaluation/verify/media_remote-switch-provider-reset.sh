#!/usr/bin/env bash
# Execution RESET: create the Remote Media type "mr_switch" (source media_remote, string source
# field field_mr_switch) whose DEFAULT display renders the source field with the WRONG provider -
# the Loom formatter at its default 960x600 - so verify FAILS until the agent switches it to the
# Google provider at 1024x768. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if (!MediaType::load("mr_switch")) {
    MediaType::create(["id" => "mr_switch", "label" => "MR Switch", "source" => "media_remote"])->save();
  }
  if (!FieldStorageConfig::loadByName("media", "field_mr_switch")) {
    FieldStorageConfig::create([
      "field_name" => "field_mr_switch", "entity_type" => "media", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("media", "mr_switch", "field_mr_switch")) {
    FieldConfig::create([
      "field_name" => "field_mr_switch", "entity_type" => "media",
      "bundle" => "mr_switch", "label" => "Remote URL", "required" => TRUE,
    ])->save();
  }
  MediaType::load("mr_switch")->set("source_configuration", ["source_field" => "field_mr_switch"])->save();
  $d = EntityViewDisplay::load("media.mr_switch.default") ?: EntityViewDisplay::create([
    "targetEntityType" => "media", "bundle" => "mr_switch", "mode" => "default", "status" => TRUE,
  ]);
  $d->setComponent("field_mr_switch", [
    "type" => "media_remote_loom", "label" => "hidden", "weight" => 0, "region" => "content",
    "settings" => [
      "formatter_class" => "Drupal\\media_remote\\Plugin\\Field\\FieldFormatter\\MediaRemoteLoomFormatter",
      "width" => 960, "height" => 600,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mr_switch default display uses media_remote_loom at 960x600 (wrong provider)"
