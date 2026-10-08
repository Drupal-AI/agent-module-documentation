#!/usr/bin/env bash
# setup: field_eru_known handler=unpublished
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eru_known")) {
    FieldStorageConfig::create(["field_name"=>"field_eru_known","entity_type"=>"node","type"=>"entity_reference","cardinality"=>1,"settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_eru_known")) {
    FieldConfig::create(["field_name"=>"field_eru_known","entity_type"=>"node","bundle"=>"article","label"=>"ERU Known","settings"=>["handler"=>"unpublished","handler_settings"=>[]]])->save();
  } else {
    $fc=FieldConfig::loadByName("node","article","field_eru_known"); $fc->setSetting("handler","unpublished")->setSetting("handler_settings",[])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_eru_known handler=unpublished"
