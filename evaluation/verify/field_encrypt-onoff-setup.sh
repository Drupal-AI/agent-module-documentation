#!/usr/bin/env bash
# Introspection SETUP: two namespaced fields on Article, field_fe_on (encrypted) and
# field_fe_off (not), so an agent can identify which one is encrypted. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_fe_on","field_fe_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"string"])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>strtoupper($fn)])->save();
    }
  }
  $on = FieldStorageConfig::loadByName("node","field_fe_on");
  $on->setThirdPartySetting("field_encrypt","encrypt",TRUE);
  $on->setThirdPartySetting("field_encrypt","properties",["value"]);
  $on->save();
  // ensure field_fe_off is NOT encrypted
  $off = FieldStorageConfig::loadByName("node","field_fe_off");
  $off->unsetThirdPartySetting("field_encrypt","encrypt");
  $off->unsetThirdPartySetting("field_encrypt","properties");
  $off->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_fe_on encrypted, field_fe_off not"
