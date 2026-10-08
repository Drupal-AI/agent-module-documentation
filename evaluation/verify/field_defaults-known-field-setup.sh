#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text field field_fd_known on Article whose
# configured Default value is the known string FD_DEFAULT_XYZ, so an agent can read the
# default off the field_config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fd_known")) {
    FieldStorageConfig::create(["field_name"=>"field_fd_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fd_known")) {
    FieldConfig::create(["field_name"=>"field_fd_known","entity_type"=>"node","bundle"=>"article","label"=>"FD Known"])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_fd_known");
  $fc->setDefaultValue([["value"=>"FD_DEFAULT_XYZ"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fd_known default_value=FD_DEFAULT_XYZ"
