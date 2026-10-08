#!/usr/bin/env bash
# Execution RESET: ensure type+field+index, index the body column as text, but do NOT index title.
# verify FAILs until the agent adds field_cfsapi_desc:title as `string`.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Index;
  if (!NodeType::load("cfsapi_eval")) { NodeType::create(["type"=>"cfsapi_eval","name"=>"CF SAPI Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cfsapi_desc")) {
    FieldStorageConfig::create(["field_name"=>"field_cfsapi_desc","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["body"=>["name"=>"body","type"=>"string_long"],"title"=>["name"=>"title","type"=>"string","max_length"=>255]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cfsapi_eval","field_cfsapi_desc")) {
    FieldConfig::create(["field_name"=>"field_cfsapi_desc","entity_type"=>"node","bundle"=>"cfsapi_eval","label"=>"Desc"])->save();
  }
  if (!Index::load("cfsapi_index")) {
    Index::create(["id"=>"cfsapi_index","name"=>"CF SAPI Index","status"=>TRUE,
      "datasource_settings"=>["entity:node"=>[]],"tracker_settings"=>["default"=>[]]])->save();
  }
  \Drupal::configFactory()->getEditable("search_api.index.cfsapi_index")
    ->set("field_settings", ["cfsapi_body"=>["label"=>"Body","datasource_id"=>"entity:node","property_path"=>"field_cfsapi_desc:body","type"=>"text"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cfsapi_index indexes body(text) only, title NOT indexed"
