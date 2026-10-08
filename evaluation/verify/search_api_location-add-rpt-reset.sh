#!/usr/bin/env bash
# Execution RESET: create sal_test_index indexing field_sal_geo ONLY as 'location' (field id
# sal_loc), with NO rpt field, so verify FAILS until the agent adds a Recursive Prefix Tree field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Index;
  use Drupal\search_api\Item\Field;
  if (!FieldStorageConfig::loadByName("node","field_sal_geo")) {
    FieldStorageConfig::create(["field_name"=>"field_sal_geo","entity_type"=>"node","type"=>"geofield"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_sal_geo")) {
    FieldConfig::create(["field_name"=>"field_sal_geo","entity_type"=>"node","bundle"=>"article","label"=>"SAL Geo"])->save();
  }
  if ($old = Index::load("sal_test_index")) { $old->delete(); }
  $index = Index::create(["id"=>"sal_test_index","name"=>"SAL Test Index","datasource_settings"=>["entity:node"=>[]],"tracker_settings"=>["default"=>[]]]);
  $f = new Field($index, "sal_loc");
  $f->setType("location"); $f->setPropertyPath("field_sal_geo"); $f->setDatasourceId("entity:node"); $f->setLabel("SAL Geo");
  $index->addField($f);
  $index->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sal_test_index has only sal_loc (location); no rpt field"
