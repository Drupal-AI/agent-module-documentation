#!/usr/bin/env bash
# Introspection SETUP: ensure the experimental submodule is enabled, add an
# entity_reference_entity_modify field field_eref_probe (targeting node) to Article and set its
# default form-display widget to entity_reference_autocomplete_with_override, so an agent can
# read the widget type back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install entity_reference_entity_modify -y >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eref_probe")) {
    FieldStorageConfig::create([
      "field_name" => "field_eref_probe", "entity_type" => "node",
      "type" => "entity_reference_entity_modify", "settings" => ["target_type" => "node"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_eref_probe")) {
    FieldConfig::create([
      "field_name" => "field_eref_probe", "entity_type" => "node",
      "bundle" => "article", "label" => "Probe contextual reference",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_eref_probe", [
    "type" => "entity_reference_autocomplete_with_override", "weight" => 64, "region" => "content",
    "settings" => ["form_mode" => "default"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_eref_probe uses entity_reference_autocomplete_with_override widget"
