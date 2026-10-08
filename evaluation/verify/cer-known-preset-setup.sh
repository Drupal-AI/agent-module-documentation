#!/usr/bin/env bash
# Introspection SETUP: create two entity-reference fields on Article and a CER preset that
# corresponds them, so an agent can read the live preset back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cer\Entity\CorrespondingReference;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["field_cer_known_a" => "CER Known A", "field_cer_known_b" => "CER Known B"] as $name => $label) {
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
  if ($p = CorrespondingReference::load("cer_known")) { $p->delete(); }
  CorrespondingReference::create([
    "id" => "cer_known", "label" => "CER Known pair", "enabled" => TRUE,
    "first_field" => "field_cer_known_a", "second_field" => "field_cer_known_b",
    "add_direction" => "prepend", "bundles" => ["node" => ["article"]],
  ])->save();
' >/dev/null 2>&1
echo "setup: preset cer_known corresponds field_cer_known_a <-> field_cer_known_b (prepend, node:article)"
