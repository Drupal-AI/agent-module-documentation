#!/usr/bin/env bash
# Introspection SETUP: create a File field field_plw_known on Article using the plupload_file_widget,
# so an agent can discover which field uses the Plupload widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_plw_known")) { FieldStorageConfig::create(["field_name"=>"field_plw_known","entity_type"=>"node","type"=>"file","cardinality"=>1])->save(); }
  if (!FieldConfig::loadByName("node","article","field_plw_known")) { FieldConfig::create(["field_name"=>"field_plw_known","entity_type"=>"node","bundle"=>"article","label"=>"PLW Known"])->save(); }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_plw_known", ["type"=>"plupload_file_widget","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_plw_known uses plupload_file_widget"
