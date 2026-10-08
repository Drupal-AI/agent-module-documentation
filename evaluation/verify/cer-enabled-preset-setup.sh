#!/usr/bin/env bash
# Introspection SETUP: create two CER presets, one enabled and one disabled, so an agent has
# to inspect the live config to say which relationship is actually active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cer\Entity\CorrespondingReference;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["field_cer_sw_a" => "CER Switch A", "field_cer_sw_b" => "CER Switch B"] as $name => $label) {
    if (!FieldStorageConfig::loadByName("node", $name)) {
      FieldStorageConfig::create([
        "field_name" => $name, "entity_type" => "node", "type" => "entity_reference",
        "settings" => ["target_type" => "node"], "cardinality" => -1,
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $name)) {
      FieldConfig::create([
        "field_name" => $name, "entity_type" => "node", "bundle" => "article", "label" => $label,
        "settings" => ["handler" => "default:node", "handler_settings" => ["target_bundles" => ["article" => "article"]]],
      ])->save();
    }
  }
  foreach (["cer_on", "cer_off"] as $id) {
    if ($p = CorrespondingReference::load($id)) { $p->delete(); }
  }
  CorrespondingReference::create([
    "id" => "cer_on", "label" => "CER Switch ON", "enabled" => TRUE,
    "first_field" => "field_cer_sw_a", "second_field" => "field_cer_sw_b",
    "add_direction" => "append", "bundles" => ["node" => ["article"]],
  ])->save();
  CorrespondingReference::create([
    "id" => "cer_off", "label" => "CER Switch OFF", "enabled" => FALSE,
    "first_field" => "field_cer_sw_b", "second_field" => "field_cer_sw_a",
    "add_direction" => "append", "bundles" => ["node" => ["*"]],
  ])->save();
' >/dev/null 2>&1
echo "setup: preset cer_on enabled, preset cer_off disabled"
