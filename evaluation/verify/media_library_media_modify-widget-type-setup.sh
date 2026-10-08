#!/usr/bin/env bash
# Introspection SETUP: add an entity_reference_entity_modify field field_mlmm_probe to Article
# and configure its default form-display component to use the media_library_media_modify_widget,
# so an agent can read the widget type back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mlmm_probe")) {
    FieldStorageConfig::create([
      "field_name" => "field_mlmm_probe", "entity_type" => "node",
      "type" => "entity_reference_entity_modify", "settings" => ["target_type" => "media"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mlmm_probe")) {
    FieldConfig::create([
      "field_name" => "field_mlmm_probe", "entity_type" => "node",
      "bundle" => "article", "label" => "Probe contextual media",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_mlmm_probe", [
    "type" => "media_library_media_modify_widget", "weight" => 60, "region" => "content",
    "settings" => ["form_mode" => "default"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_mlmm_probe uses media_library_media_modify_widget"
