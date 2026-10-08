#!/usr/bin/env bash
# Introspection SETUP: create a list_string field field_ms_known on Article and set its default
# form-display widget to 'multiselect', so an agent can read back which field uses it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ms_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ms_known", "entity_type" => "node", "type" => "list_string",
      "cardinality" => -1,
      "settings" => ["allowed_values" => ["a" => "Apple", "b" => "Banana", "c" => "Cherry"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ms_known")) {
    FieldConfig::create([
      "field_name" => "field_ms_known", "entity_type" => "node", "bundle" => "article",
      "label" => "MS Known",
    ])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default")
    ->setComponent("field_ms_known", ["type" => "multiselect", "weight" => 50, "region" => "content"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ms_known uses multiselect widget"
