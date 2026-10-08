#!/usr/bin/env bash
# Introspection SETUP: create string field field_epp_update on Article with an epp value AND
# on_update = TRUE, so an agent can determine it reapplies on update. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_epp_update")) {
    FieldStorageConfig::create(["field_name"=>"field_epp_update","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_epp_update")) {
    FieldConfig::create(["field_name"=>"field_epp_update","entity_type"=>"node","bundle"=>"article","label"=>"EPP Update"])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_epp_update");
  $fc->setThirdPartySetting("epp", "value", "Reapplied every save");
  $fc->setThirdPartySetting("epp", "on_update", TRUE);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_epp_update epp.on_update = TRUE"
