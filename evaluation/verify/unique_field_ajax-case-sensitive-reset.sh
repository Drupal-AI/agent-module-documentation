#!/usr/bin/env bash
# Execution RESET: ensure a single-value string field field_ufa_case exists on Article with NO
# unique_field_ajax settings (so verify FAILS until the agent makes it unique AND case-sensitive).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ufa_case")) {
    FieldStorageConfig::create(["field_name"=>"field_ufa_case","entity_type"=>"node","type"=>"string","cardinality"=>1])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_ufa_case");
  if (!$fc) {
    $fc = FieldConfig::create(["field_name"=>"field_ufa_case","entity_type"=>"node","bundle"=>"article","label"=>"Case Code"]);
  }
  $fc->unsetThirdPartySetting("unique_field_ajax", "unique");
  $fc->unsetThirdPartySetting("unique_field_ajax", "case_sensitive");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_ufa_case present with NO unique_field_ajax settings"
