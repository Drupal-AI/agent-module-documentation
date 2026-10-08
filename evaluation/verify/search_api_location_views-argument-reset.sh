#!/usr/bin/env bash
# Execution RESET: index salv_index exists but does NOT index the geofield at all (only the node
# title as a string), so the search_api_location_point argument is NOT exposed -> verify FAILS.
# The geofield field_salv_geo exists on Article, ready to be added.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Index;
  use Drupal\search_api\Item\Field;
  if (!FieldStorageConfig::loadByName("node","field_salv_geo")) FieldStorageConfig::create(["field_name"=>"field_salv_geo","entity_type"=>"node","type"=>"geofield"])->save();
  if (!FieldConfig::loadByName("node","article","field_salv_geo")) FieldConfig::create(["field_name"=>"field_salv_geo","entity_type"=>"node","bundle"=>"article","label"=>"SALV Geo"])->save();
  if ($o=Index::load("salv_index")) $o->delete();
  $i=Index::create(["id"=>"salv_index","name"=>"SALV Index","datasource_settings"=>["entity:node"=>[]],"tracker_settings"=>["default"=>[]]]);
  $f=new Field($i,"salv_title"); $f->setType("string"); $f->setPropertyPath("title"); $f->setDatasourceId("entity:node"); $f->setLabel("Title"); $i->addField($f);
  $i->save();
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: salv_index has no location field (geofield not indexed)"
