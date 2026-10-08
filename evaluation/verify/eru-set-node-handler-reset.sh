#!/usr/bin/env bash
# reset: field_eru_task handler=default:node (published only)
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eru_task")) {
    FieldStorageConfig::create(["field_name"=>"field_eru_task","entity_type"=>"node","type"=>"entity_reference","cardinality"=>1,"settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_eru_task")) {
    FieldConfig::create(["field_name"=>"field_eru_task","entity_type"=>"node","bundle"=>"article","label"=>"ERU Task","settings"=>["handler"=>"default:node","handler_settings"=>[]]])->save();
  } else {
    $fc=FieldConfig::loadByName("node","article","field_eru_task"); $fc->setSetting("handler","default:node")->setSetting("handler_settings",[])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eru_task handler=default:node (published only)"
