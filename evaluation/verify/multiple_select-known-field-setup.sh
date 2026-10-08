#!/usr/bin/env bash
# Introspection SETUP: create a multi-value list_string checkboxes field on Article and
# register it in multiple_select.settings so an inspecting agent can read back which field
# has the select-all helper enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ms_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ms_known", "entity_type" => "node",
      "type" => "list_string", "cardinality" => -1,
      "settings" => ["allowed_values" => ["a" => "Alpha", "b" => "Beta", "c" => "Gamma"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ms_known")) {
    FieldConfig::create([
      "field_name" => "field_ms_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Options",
    ])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $fd->setComponent("field_ms_known", ["type" => "options_buttons", "weight" => 50, "region" => "content"])->save();
  \Drupal::configFactory()->getEditable("multiple_select.settings")
    ->set("table", json_encode(["node-article" => ["field_ms_known"]]))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ms_known registered in multiple_select.settings for node-article"
