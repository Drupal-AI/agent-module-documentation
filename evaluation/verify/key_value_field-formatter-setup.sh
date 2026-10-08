#!/usr/bin/env bash
# Introspection SETUP: create a key_value field field_kvf_fmt on Article and set its formatter
# on the default view display to value_only=TRUE (hide the key), so an inspecting agent can read
# back the display config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_kvf_fmt")) {
    FieldStorageConfig::create([
      "field_name" => "field_kvf_fmt", "entity_type" => "node", "type" => "key_value",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_kvf_fmt")) {
    FieldConfig::create([
      "field_name" => "field_kvf_fmt", "entity_type" => "node",
      "bundle" => "article", "label" => "Formatted Spec",
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_kvf_fmt", ["type" => "key_value", "settings" => ["value_only" => TRUE]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_kvf_fmt formatter key_value value_only=TRUE"
