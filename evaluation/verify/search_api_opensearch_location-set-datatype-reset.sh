#!/usr/bin/env bash
# Execution RESET: ensure a geofield exists on Article and a Search API index saol_task has that
# field typed as 'string' (NOT location), so verify FAILS until the agent sets it to 'location'.
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
  if ($i = Index::load("saol_task")) { $i->delete(); }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\search_api\Entity\Index;
  Index::create([
    "id"=>"saol_task","name"=>"SAOL task index","status"=>TRUE,
    "datasource_settings"=>["entity:node"=>[]],
    "field_settings"=>["field_saol_geo"=>["label"=>"Geo","datasource_id"=>"entity:node","property_path"=>"field_saol_geo","type"=>"string"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api.index saol_task field_saol_geo type=string"
