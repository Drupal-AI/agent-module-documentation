#!/usr/bin/env bash
# Introspection SETUP: create image field field_sir_known on Article with enable_rotate=TRUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_sir_known")) {
    FieldStorageConfig::create(["field_name"=>"field_sir_known","entity_type"=>"node","type"=>"image"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_sir_known");
  if (!$fc) { $fc = FieldConfig::create(["field_name"=>"field_sir_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Image"]); }
  $fc->setThirdPartySetting("simple_image_rotate","enable_rotate",TRUE); $fc->save();
' >/dev/null 2>&1
echo "setup: field_sir_known image field, enable_rotate=TRUE"
