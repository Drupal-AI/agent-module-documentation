#!/usr/bin/env bash
# Introspection SETUP: create a string field field_epp_known on Article carrying an epp prepopulate
# value third-party setting, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_epp_known")) {
    FieldStorageConfig::create(["field_name"=>"field_epp_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_epp_known")) {
    FieldConfig::create(["field_name"=>"field_epp_known","entity_type"=>"node","bundle"=>"article","label"=>"EPP Known"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_epp_known");
  $fc->setThirdPartySetting("epp", "value", "Prefilled EPP Marker");
  $fc->setThirdPartySetting("epp", "on_update", FALSE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_epp_known epp.value = 'Prefilled EPP Marker'"
