#!/usr/bin/env bash
# Introspection SETUP: create sms_phone_number field field_spn_known on Article with verify=required. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_spn_known")) {
    FieldStorageConfig::create(["field_name"=>"field_spn_known","entity_type"=>"node","type"=>"sms_phone_number"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_spn_known")) {
    FieldConfig::create(["field_name"=>"field_spn_known","entity_type"=>"node","bundle"=>"article","label"=>"Known SMS Phone","settings"=>["verify"=>"required"]])->save();
  } else { $fc=FieldConfig::loadByName("node","article","field_spn_known"); $fc->setSetting("verify","required"); $fc->save(); }
' >/dev/null 2>&1
echo "setup: field_spn_known sms_phone_number verify=required"
