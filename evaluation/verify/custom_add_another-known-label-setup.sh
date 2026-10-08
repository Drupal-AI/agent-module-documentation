#!/usr/bin/env bash
# Introspection SETUP: content type caa_known with an unlimited (multi-value) string field
# field_caa_lbl whose custom_add_another 'Add another item' label is customised to
# 'Add another highlight'. Agent reads it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("caa_known")) { NodeType::create(["type"=>"caa_known","name"=>"CAA Known"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_caa_lbl")) {
    FieldStorageConfig::create(["field_name"=>"field_caa_lbl","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","caa_known","field_caa_lbl")) {
    FieldConfig::create(["field_name"=>"field_caa_lbl","entity_type"=>"node","bundle"=>"caa_known","label"=>"Highlights"])->save();
  }
  $fc = FieldConfig::loadByName("node","caa_known","field_caa_lbl");
  $fc->setThirdPartySetting("custom_add_another","custom_add_another","Add another highlight");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.caa_known field_caa_lbl custom add-another label = 'Add another highlight'"
