#!/usr/bin/env bash
# Introspection SETUP (serial M1): create a serial field field_srl_known on Article with a
# starting value of 1000. The agent must inspect the live field storage config to report the
# starting value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_srl_known")) {
    FieldStorageConfig::create(["field_name"=>"field_srl_known","entity_type"=>"node","type"=>"serial",
      "settings"=>["start_value"=>1000,"init_existing_entities"=>0]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_srl_known")) {
    FieldConfig::create(["field_name"=>"field_srl_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Serial"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_srl_known is a serial field with start_value=1000"
