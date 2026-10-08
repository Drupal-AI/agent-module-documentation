#!/usr/bin/env bash
# Introspection SETUP: add field_mlmm_setting (entity_reference_entity_modify) to Article with
# the media_library_media_modify_widget where the 'multi_edit_on_create' setting is TRUE, so an
# agent can read the enabled on-create behaviour back from config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mlmm_setting")) {
    FieldStorageConfig::create([
      "field_name" => "field_mlmm_setting", "entity_type" => "node",
      "type" => "entity_reference_entity_modify", "settings" => ["target_type" => "media"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mlmm_setting")) {
    FieldConfig::create([
      "field_name" => "field_mlmm_setting", "entity_type" => "node",
      "bundle" => "article", "label" => "Setting contextual media",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_mlmm_setting", [
    "type" => "media_library_media_modify_widget", "weight" => 61, "region" => "content",
    "settings" => ["form_mode" => "default", "multi_edit_on_create" => TRUE, "no_edit_on_create" => FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_mlmm_setting widget has multi_edit_on_create=TRUE"
