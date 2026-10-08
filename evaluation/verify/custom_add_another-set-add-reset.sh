#!/usr/bin/env bash
# Execution RESET: content type caa_add with an unlimited string field field_caa_add and NO
# custom_add_another third-party setting (so verify FAILS until the agent sets it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("caa_add")) { NodeType::create(["type"=>"caa_add","name"=>"CAA Add"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_caa_add")) {
    FieldStorageConfig::create(["field_name"=>"field_caa_add","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","caa_add","field_caa_add")) {
    FieldConfig::create(["field_name"=>"field_caa_add","entity_type"=>"node","bundle"=>"caa_add","label"=>"Highlights"])->save();
  }
  $fc = FieldConfig::loadByName("node","caa_add","field_caa_add");
  $fc->unsetThirdPartySetting("custom_add_another","custom_add_another");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.caa_add field_caa_add present (unlimited), custom add-another label unset"
