#!/usr/bin/env bash
# Introspection SETUP: ensure content type cf_eval exists and create Custom Field field_cf_cols
# with two subfield columns headline(string) + rank(integer), so an agent can read them back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_eval")) { NodeType::create(["type"=>"cf_eval","name"=>"CF Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_cf_cols")) {
    FieldStorageConfig::create([
      "field_name"=>"field_cf_cols","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>[
        "headline"=>["name"=>"headline","type"=>"string","max_length"=>255],
        "rank"=>["name"=>"rank","type"=>"integer"],
      ]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "cf_eval", "field_cf_cols")) {
    FieldConfig::create(["field_name"=>"field_cf_cols","entity_type"=>"node","bundle"=>"cf_eval","label"=>"Cols"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cf_eval.field_cf_cols has columns headline(string), rank(integer)"
