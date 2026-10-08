#!/usr/bin/env bash
# Introspection SETUP (serial M2): add a serial field field_srl_auto to Article (plus a plain
# integer field_srl_plain as a red herring). The agent must inspect the live field config to
# name which Article field is the serial (auto-increment) one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_srl_auto")) {
    FieldStorageConfig::create(["field_name"=>"field_srl_auto","entity_type"=>"node","type"=>"serial",
      "settings"=>["start_value"=>1,"init_existing_entities"=>0]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_srl_auto")) {
    FieldConfig::create(["field_name"=>"field_srl_auto","entity_type"=>"node","bundle"=>"article","label"=>"Auto Number"])->save();
  }
  if (!FieldStorageConfig::loadByName("node","field_srl_plain")) {
    FieldStorageConfig::create(["field_name"=>"field_srl_plain","entity_type"=>"node","type"=>"integer"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_srl_plain")) {
    FieldConfig::create(["field_name"=>"field_srl_plain","entity_type"=>"node","bundle"=>"article","label"=>"Plain Integer"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Article has serial field_srl_auto and plain integer field_srl_plain"
