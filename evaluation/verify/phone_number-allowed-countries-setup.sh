#!/usr/bin/env bash
# Introspection SETUP: create phone_number field field_pn_known on Article, allowed_countries=[US,GB]. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pn_known")) {
    FieldStorageConfig::create(["field_name"=>"field_pn_known","entity_type"=>"node","type"=>"phone_number"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pn_known")) {
    FieldConfig::create(["field_name"=>"field_pn_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Phone",
      "settings"=>["allowed_countries"=>["US","GB"],"allowed_types"=>[],"extension_field"=>FALSE]])->save();
  } else {
    $fc=FieldConfig::loadByName("node","article","field_pn_known"); $fc->setSetting("allowed_countries",["US","GB"]); $fc->save();
  }
' >/dev/null 2>&1
echo "setup: field_pn_known phone_number allowed_countries=[US,GB]"
