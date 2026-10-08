#!/usr/bin/env bash
# Introspection SETUP: create a geofield on Article and a Search API index whose geo field uses
# the 'location' (Geopoint) data type, so an agent can read that field's data type. Config only.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Index;
  if (!FieldStorageConfig::loadByName("node","field_saol_geo")) {
    FieldStorageConfig::create(["field_name"=>"field_saol_geo","entity_type"=>"node","type"=>"geofield"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_saol_geo")) {
    FieldConfig::create(["field_name"=>"field_saol_geo","entity_type"=>"node","bundle"=>"article","label"=>"Geo"])->save();
  }
  if (!Index::load("saol_med_idx")) {
    Index::create([
      "id"=>"saol_med_idx","name"=>"SAOL medium index","status"=>TRUE,
      "datasource_settings"=>["entity:node"=>[]],
      "field_settings"=>["field_saol_geo"=>["label"=>"Geo","datasource_id"=>"entity:node","property_path"=>"field_saol_geo","type"=>"location"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api.index saol_med_idx field_saol_geo type=location"
