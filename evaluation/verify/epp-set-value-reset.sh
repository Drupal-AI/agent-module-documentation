#!/usr/bin/env bash
# Execution RESET: ensure string field field_epp_task exists on Article WITHOUT any epp value, so
# verify FAILS until the agent sets one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_epp_task")) {
    FieldStorageConfig::create(["field_name"=>"field_epp_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_epp_task")) {
    FieldConfig::create(["field_name"=>"field_epp_task","entity_type"=>"node","bundle"=>"article","label"=>"EPP Task"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_epp_task");
  $fc->unsetThirdPartySetting("epp", "value");
  $fc->unsetThirdPartySetting("epp", "on_update");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_epp_task present with NO epp value"
