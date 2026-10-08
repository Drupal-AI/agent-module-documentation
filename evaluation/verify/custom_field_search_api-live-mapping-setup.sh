#!/usr/bin/env bash
# Introspection SETUP: ensure content type cfsapi_eval + Custom Field field_cfsapi_desc (with a
# string_long column 'body') exist, so the site has a real custom_field_string_long property. The
# answer (custom_field_string_long -> text) comes from the live search_api field-type mapping.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfsapi_eval")) { NodeType::create(["type"=>"cfsapi_eval","name"=>"CF SAPI Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cfsapi_desc")) {
    FieldStorageConfig::create(["field_name"=>"field_cfsapi_desc","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["body"=>["name"=>"body","type"=>"string_long"],"title"=>["name"=>"title","type"=>"string","max_length"=>255]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cfsapi_eval","field_cfsapi_desc")) {
    FieldConfig::create(["field_name"=>"field_cfsapi_desc","entity_type"=>"node","bundle"=>"cfsapi_eval","label"=>"Desc"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cfsapi_eval + field_cfsapi_desc (string_long body) present"
