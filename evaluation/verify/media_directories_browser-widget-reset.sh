#!/usr/bin/env bash
# Execution RESET for "use the browser widget on a media reference field".
# Ensures the Article content type has an entity_reference field field_mdb_assets pointing at
# media, and forces its default form-display component back to the core
# entity_reference_autocomplete widget so verify FAILS until the agent switches it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;

  if (!FieldStorageConfig::loadByName("node", "field_mdb_assets")) {
    FieldStorageConfig::create([
      "field_name" => "field_mdb_assets",
      "entity_type" => "node",
      "type" => "entity_reference",
      "settings" => ["target_type" => "media"],
      "cardinality" => -1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mdb_assets")) {
    FieldConfig::create([
      "field_name" => "field_mdb_assets",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "MDB assets",
      "settings" => [
        "handler" => "default:media",
        "handler_settings" => ["target_bundles" => ["image" => "image"]],
      ],
    ])->save();
  }

  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_mdb_assets", [
    "type" => "entity_reference_autocomplete",
    "weight" => 60,
    "region" => "content",
    "settings" => ["match_operator" => "CONTAINS", "size" => 60, "placeholder" => ""],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1

echo "reset: node.article field_mdb_assets uses entity_reference_autocomplete"
