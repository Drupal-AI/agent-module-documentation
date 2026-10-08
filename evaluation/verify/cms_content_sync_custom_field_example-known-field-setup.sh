#!/usr/bin/env bash
# Introspection SETUP: create a field field_ccs_known of type cs_custom_field on Article.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ccs_known")) {
    FieldStorageConfig::create(["field_name"=>"field_ccs_known","entity_type"=>"node","type"=>"cs_custom_field"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ccs_known")) {
    FieldConfig::create(["field_name"=>"field_ccs_known","entity_type"=>"node","bundle"=>"article","label"=>"CCS Known Custom"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ccs_known type=cs_custom_field"
