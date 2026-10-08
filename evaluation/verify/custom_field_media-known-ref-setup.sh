#!/usr/bin/env bash
# Introspection SETUP: create Custom Field field_cfmedia_ref with an entity_reference column
# 'asset' whose target_type is media, so the agent can read back what it references. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfmedia_eval")) { NodeType::create(["type"=>"cfmedia_eval","name"=>"CF Media Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cfmedia_ref")) {
    FieldStorageConfig::create(["field_name"=>"field_cfmedia_ref","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["asset"=>["name"=>"asset","type"=>"entity_reference","target_type"=>"media"]]]])->save();
  }
  if (!FieldConfig::loadByName("node","cfmedia_eval","field_cfmedia_ref")) {
    FieldConfig::create(["field_name"=>"field_cfmedia_ref","entity_type"=>"node","bundle"=>"cfmedia_eval","label"=>"Ref"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cfmedia_eval.field_cfmedia_ref asset column target_type=media"
