#!/usr/bin/env bash
# Execution RESET: index salv_index indexes field_salv_geo as salv_loc with the WRONG type
# ('string'), so the search_api_location Views filter is NOT exposed -> verify FAILS.
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
  $f=new Field($i,"salv_loc"); $f->setType("string"); $f->setPropertyPath("field_salv_geo"); $f->setDatasourceId("entity:node"); $f->setLabel("SALV Geo"); $i->addField($f);
  $i->save();
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: salv_index field salv_loc type=string (no location Views filter)"
