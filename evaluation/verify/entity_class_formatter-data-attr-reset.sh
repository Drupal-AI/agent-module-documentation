#!/usr/bin/env bash
# Execution RESET: ensure an integer field field_ecf_cols exists on Article and force its
# component in core.entity_view_display.node.article.default back to the plain "number_integer"
# formatter (so verify FAILS until the agent switches it to entity_class_formatter writing a
# data-ecf-columns attribute). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ecf_cols")) {
    FieldStorageConfig::create([
      "field_name" => "field_ecf_cols", "entity_type" => "node", "type" => "integer",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ecf_cols")) {
    FieldConfig::create([
      "field_name" => "field_ecf_cols", "entity_type" => "node",
      "bundle" => "article", "label" => "ECF Columns",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ecf_cols", [
    "type" => "number_integer", "label" => "above", "weight" => 64, "region" => "content",
    "settings" => ["thousand_separator" => "", "prefix_suffix" => TRUE],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ecf_cols set to number_integer (not entity_class_formatter)"
