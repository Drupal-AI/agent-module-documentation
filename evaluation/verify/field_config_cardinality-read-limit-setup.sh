#!/usr/bin/env bash
# Introspection SETUP: fcc_m1 field_fcc_m1 unlimited storage, per-instance limit 2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("fcc_m1")) { NodeType::create(["type" => "fcc_m1", "name" => "fcc_m1"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_fcc_m1")) {
    FieldStorageConfig::create(["field_name" => "field_fcc_m1", "entity_type" => "node", "type" => "string", "cardinality" => -1])->save();
  }
  $fc = FieldConfig::loadByName("node", "fcc_m1", "field_fcc_m1");
  if (!$fc) { $fc = FieldConfig::create(["field_name" => "field_fcc_m1", "entity_type" => "node", "bundle" => "fcc_m1", "label" => "field_fcc_m1"]); }
  $fc->unsetThirdPartySetting("field_config_cardinality", "cardinality_config");
  $fc->setThirdPartySetting("field_config_cardinality", "cardinality_config", "2");
  $fc->save();
' >/dev/null 2>&1
echo "ready: node.fcc_m1 field field_fcc_m1 (storage unlimited)"
