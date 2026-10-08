#!/usr/bin/env bash
# setup: field_eru_terms handler=unpublished_taxonomy_term
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eru_terms")) {
    FieldStorageConfig::create(["field_name"=>"field_eru_terms","entity_type"=>"node","type"=>"entity_reference","cardinality"=>1,"settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_eru_terms")) {
    FieldConfig::create(["field_name"=>"field_eru_terms","entity_type"=>"node","bundle"=>"article","label"=>"ERU Terms","settings"=>["handler"=>"unpublished_taxonomy_term","handler_settings"=>[]]])->save();
  } else {
    $fc=FieldConfig::loadByName("node","article","field_eru_terms"); $fc->setSetting("handler","unpublished_taxonomy_term")->setSetting("handler_settings",[])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_eru_terms handler=unpublished_taxonomy_term"
