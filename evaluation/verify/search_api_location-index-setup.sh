#!/usr/bin/env bash
# Introspection SETUP: create a self-contained Search API index sal_test_index (no server) that
# indexes a geofield twice: field id sal_loc as the 'location' (Latitude/Longitude) data type and
# field id sal_rpt as the 'rpt' (Spatial Recursive Prefix Tree) data type. Idempotent. Exit 0.
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
  foreach (["sal_loc"=>"location","sal_rpt"=>"rpt"] as $fid=>$type) {
    $f = new Field($index, $fid);
    $f->setType($type); $f->setPropertyPath("field_sal_geo"); $f->setDatasourceId("entity:node"); $f->setLabel("SAL Geo (".$type.")");
    $index->addField($f);
  }
  $index->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: index sal_test_index has sal_loc (location) and sal_rpt (rpt)"
