#!/usr/bin/env bash
# Execution RESET: ensure entity_reference field field_erp_task exists on Article (targets
# nodes) with entity_reference_purger remove_orphaned=FALSE, so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_erp_task")) {
    FieldStorageConfig::create(["field_name"=>"field_erp_task","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_erp_task");
  if (!$fc) { $fc = FieldConfig::create(["field_name"=>"field_erp_task","entity_type"=>"node","bundle"=>"article","label"=>"ERP Task","settings"=>["handler"=>"default:node"]]); }
  $fc->setThirdPartySetting("entity_reference_purger","remove_orphaned",FALSE);
  $fc->setThirdPartySetting("entity_reference_purger","use_queue",FALSE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_erp_task remove_orphaned=FALSE"
