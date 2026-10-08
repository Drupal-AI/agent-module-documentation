#!/usr/bin/env bash
# Introspection SETUP for bp_quicklinks: create a Paragraphs field field_bpquick_slot on
# node.article whose handler_settings.target_bundles allows EXACTLY TWO bundles —
# bp_quicklinks and bp_simple. The agent must read the live field config to name the second
# allowed bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  if (!FieldStorageConfig::loadByName("node", "field_bpquick_slot")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpquick_slot", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $settings = [
    "handler" => "default:paragraph",
    "handler_settings" => [
      "negate" => 0,
      "target_bundles" => [
        "bp_quicklinks" => "bp_quicklinks",
        "bp_simple" => "bp_simple",
      ],
    ],
  ];
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpquick_slot")) {
    $fc->set("settings", $settings)->save();
  }
  else {
    FieldConfig::create([
      "field_name" => "field_bpquick_slot", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Quicklinks Slot",
      "settings" => $settings,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_bpquick_slot allows target_bundles bp_quicklinks + bp_simple"
