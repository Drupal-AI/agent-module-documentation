#!/usr/bin/env bash
# Introspection SETUP: create phone_number field field_pn_uniq on Article with storage unique=1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pn_uniq")) {
    FieldStorageConfig::create(["field_name"=>"field_pn_uniq","entity_type"=>"node","type"=>"phone_number","settings"=>["unique"=>1]])->save();
  } else { $fs=FieldStorageConfig::loadByName("node","field_pn_uniq"); $fs->setSetting("unique",1); $fs->save(); }
  if (!FieldConfig::loadByName("node","article","field_pn_uniq")) {
    FieldConfig::create(["field_name"=>"field_pn_uniq","entity_type"=>"node","bundle"=>"article","label"=>"Unique Phone"])->save();
  }
' >/dev/null 2>&1
echo "setup: field_pn_uniq phone_number storage unique=1"
