#!/usr/bin/env bash
# Introspection SETUP: create a namespaced string field field_fe_known on Article and mark it
# encrypted via field_encrypt (encrypt=true, properties=[value]) so an agent can read back
# which field is encrypted. Config-only (no entity saved, no profile needed). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fe_known")) {
    FieldStorageConfig::create(["field_name"=>"field_fe_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fe_known")) {
    FieldConfig::create(["field_name"=>"field_fe_known","entity_type"=>"node","bundle"=>"article","label"=>"FE Known Secret"])->save();
  }
  $fs = FieldStorageConfig::loadByName("node", "field_fe_known");
  $fs->setThirdPartySetting("field_encrypt","encrypt",TRUE);
  $fs->setThirdPartySetting("field_encrypt","properties",["value"]);
  $fs->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.field_fe_known has field_encrypt.encrypt=true properties=[value]"
