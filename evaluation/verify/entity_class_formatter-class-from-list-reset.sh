#!/usr/bin/env bash
# Execution RESET: ensure a string field field_ecf_task exists on Article and force its
# component in core.entity_view_display.node.article.default back to the plain "string"
# formatter (so verify FAILS until the agent switches it to entity_class_formatter with the
# required prefix). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ecf_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_ecf_task", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ecf_task")) {
    FieldConfig::create([
      "field_name" => "field_ecf_task", "entity_type" => "node",
      "bundle" => "article", "label" => "ECF Task Palette",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ecf_task", [
    "type" => "string", "label" => "above", "weight" => 63, "region" => "content",
    "settings" => ["link_to_entity" => FALSE], "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ecf_task set to string formatter (not entity_class_formatter)"
