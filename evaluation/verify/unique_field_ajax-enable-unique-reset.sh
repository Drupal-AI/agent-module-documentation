#!/usr/bin/env bash
# Execution RESET: ensure a single-value string field field_ufa_task exists on Article with NO
# unique_field_ajax setting (so verify FAILS until the agent marks it unique). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ufa_task")) {
    FieldStorageConfig::create(["field_name"=>"field_ufa_task","entity_type"=>"node","type"=>"string","cardinality"=>1])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_ufa_task");
  if (!$fc) {
    $fc = FieldConfig::create(["field_name"=>"field_ufa_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Code"]);
  }
  $fc->unsetThirdPartySetting("unique_field_ajax", "unique");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ufa_task present with NO unique_field_ajax.unique"
