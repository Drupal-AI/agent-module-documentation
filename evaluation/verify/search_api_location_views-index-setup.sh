#!/usr/bin/env bash
# Introspection SETUP: create a Search API index salv_index (no server) indexing a geofield
# (field_salv_geo) as field id salv_loc with the 'location' data type, so its Views handlers are
# exposed in the index's Views data. Idempotent. Exit 0.
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
  $f=new Field($i,"salv_loc"); $f->setType("location"); $f->setPropertyPath("field_salv_geo"); $f->setDatasourceId("entity:node"); $f->setLabel("SALV Geo"); $i->addField($f);
  $i->save();
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: index salv_index has salv_loc (location); Views handlers exposed"
