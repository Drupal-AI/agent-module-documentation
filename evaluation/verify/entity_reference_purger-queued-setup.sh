#!/usr/bin/env bash
# Introspection SETUP: create an entity_reference field field_erp_q on Article (targets nodes)
# and enable entity_reference_purger orphan removal VIA THE QUEUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_erp_q")) {
    FieldStorageConfig::create(["field_name"=>"field_erp_q","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_erp_q");
  if (!$fc) { $fc = FieldConfig::create(["field_name"=>"field_erp_q","entity_type"=>"node","bundle"=>"article","label"=>"ERP Queued","settings"=>["handler"=>"default:node"]]); }
  $fc->setThirdPartySetting("entity_reference_purger","remove_orphaned",TRUE);
  $fc->setThirdPartySetting("entity_reference_purger","use_queue",TRUE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_erp_q remove_orphaned=TRUE use_queue=TRUE (queued)"
