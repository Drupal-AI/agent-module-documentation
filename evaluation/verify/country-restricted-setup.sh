#!/usr/bin/env bash
# Introspection SETUP: create a country field on Article restricted to US, GB, FR. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ctry_known")) {
    FieldStorageConfig::create(["field_name"=>"field_ctry_known","entity_type"=>"node","type"=>"country"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ctry_known")) {
    FieldConfig::create([
      "field_name"=>"field_ctry_known","entity_type"=>"node","bundle"=>"article",
      "label"=>"Known Country","settings"=>["selectable_countries"=>["US","GB","FR"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ctry_known (country) selectable_countries=[US,GB,FR]"
