#!/usr/bin/env bash
# Execution RESET: fcc_h1 field_fcc_h1 unlimited storage, NO per-instance override so verify FAILS until set. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("fcc_h1")) { NodeType::create(["type" => "fcc_h1", "name" => "fcc_h1"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_fcc_h1")) {
    FieldStorageConfig::create(["field_name" => "field_fcc_h1", "entity_type" => "node", "type" => "string", "cardinality" => -1])->save();
  }
  $fc = FieldConfig::loadByName("node", "fcc_h1", "field_fcc_h1");
  if (!$fc) { $fc = FieldConfig::create(["field_name" => "field_fcc_h1", "entity_type" => "node", "bundle" => "fcc_h1", "label" => "field_fcc_h1"]); }
  $fc->unsetThirdPartySetting("field_config_cardinality", "cardinality_config");
  
  $fc->save();
' >/dev/null 2>&1
echo "ready: node.fcc_h1 field field_fcc_h1 (storage unlimited)"
