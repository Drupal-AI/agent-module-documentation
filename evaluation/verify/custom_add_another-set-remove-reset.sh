#!/usr/bin/env bash
# Execution RESET: content type caa_rm with an unlimited string field field_caa_rm and NO
# custom_remove third-party setting (so verify FAILS until the agent sets it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("caa_rm")) { NodeType::create(["type"=>"caa_rm","name"=>"CAA Rm"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_caa_rm")) {
    FieldStorageConfig::create(["field_name"=>"field_caa_rm","entity_type"=>"node","type"=>"string","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","caa_rm","field_caa_rm")) {
    FieldConfig::create(["field_name"=>"field_caa_rm","entity_type"=>"node","bundle"=>"caa_rm","label"=>"Highlights"])->save();
  }
  $fc = FieldConfig::loadByName("node","caa_rm","field_caa_rm");
  $fc->unsetThirdPartySetting("custom_add_another","custom_remove");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.caa_rm field_caa_rm present (unlimited), custom remove label unset"
