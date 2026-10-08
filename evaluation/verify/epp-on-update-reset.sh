#!/usr/bin/env bash
# Execution RESET: ensure field_epp_task on Article has an epp value but on_update = FALSE, so
# verify FAILS until the agent turns on "Also on update". Idempotent. Exit 0.
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
  $fc->setThirdPartySetting("epp", "value", "Task default value");
  $fc->setThirdPartySetting("epp", "on_update", FALSE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_epp_task epp.on_update = FALSE"
