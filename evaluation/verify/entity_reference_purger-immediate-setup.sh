#!/usr/bin/env bash
# Introspection SETUP: create an entity_reference field field_erp_ref on Article (targets
# nodes) and enable entity_reference_purger orphan removal WITHOUT the queue (immediate purge).
# The agent must read the third-party settings back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_erp_ref")) {
    FieldStorageConfig::create(["field_name"=>"field_erp_ref","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_erp_ref");
  if (!$fc) { $fc = FieldConfig::create(["field_name"=>"field_erp_ref","entity_type"=>"node","bundle"=>"article","label"=>"ERP Ref","settings"=>["handler"=>"default:node"]]); }
  $fc->setThirdPartySetting("entity_reference_purger","remove_orphaned",TRUE);
  $fc->setThirdPartySetting("entity_reference_purger","use_queue",FALSE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_erp_ref remove_orphaned=TRUE use_queue=FALSE (immediate)"
