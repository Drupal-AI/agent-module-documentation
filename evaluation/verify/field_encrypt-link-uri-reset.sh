#!/usr/bin/env bash
# Execution RESET: ensure a namespaced link field field_fe_link exists on Article and is NOT
# encrypted. Verify FAILS until agent encrypts ONLY the uri property. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fe_link")) {
    FieldStorageConfig::create(["field_name"=>"field_fe_link","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fe_link")) {
    FieldConfig::create(["field_name"=>"field_fe_link","entity_type"=>"node","bundle"=>"article","label"=>"FE Secret Link"])->save();
  }
  $fs = FieldStorageConfig::loadByName("node","field_fe_link");
  $fs->unsetThirdPartySetting("field_encrypt","encrypt");
  $fs->unsetThirdPartySetting("field_encrypt","properties");
  $fs->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fe_link present, encryption OFF"
