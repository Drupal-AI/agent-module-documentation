#!/usr/bin/env bash
# Introspection SETUP: create a key_value field field_kvf_known on Article with a distinctive
# key_max_length storage setting (42) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_kvf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_kvf_known", "entity_type" => "node",
      "type" => "key_value", "settings" => ["key_max_length" => 42, "key_is_ascii" => FALSE],
    ])->save();
  }
  else {
    $fs = FieldStorageConfig::loadByName("node", "field_kvf_known");
    $fs->setSetting("key_max_length", 42)->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_kvf_known")) {
    FieldConfig::create([
      "field_name" => "field_kvf_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Spec",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_kvf_known (key_value) has key_max_length=42"
