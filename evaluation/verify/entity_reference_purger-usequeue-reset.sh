#!/usr/bin/env bash
# Execution RESET: ensure field_erp_qtask exists on Article (targets nodes) with
# remove_orphaned=TRUE but use_queue=FALSE, so verify FAILS until the agent turns the queue on.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_erp_qtask")) {
    FieldStorageConfig::create(["field_name"=>"field_erp_qtask","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_erp_qtask");
  if (!$fc) { $fc = FieldConfig::create(["field_name"=>"field_erp_qtask","entity_type"=>"node","bundle"=>"article","label"=>"ERP QTask","settings"=>["handler"=>"default:node"]]); }
  $fc->setThirdPartySetting("entity_reference_purger","remove_orphaned",TRUE);
  $fc->setThirdPartySetting("entity_reference_purger","use_queue",FALSE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_erp_qtask remove_orphaned=TRUE use_queue=FALSE"
