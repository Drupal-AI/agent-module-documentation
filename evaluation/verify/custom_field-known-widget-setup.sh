#!/usr/bin/env bash
# Introspection SETUP: ensure cf_eval exists, create Custom Field field_cf_wid with one string
# column 'body', and configure the default form display so the field uses the custom_flex base
# widget with the 'body' column using the textarea widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_eval")) { NodeType::create(["type"=>"cf_eval","name"=>"CF Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_cf_wid")) {
    FieldStorageConfig::create([
      "field_name"=>"field_cf_wid","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["body"=>["name"=>"body","type"=>"string_long"]]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "cf_eval", "field_cf_wid")) {
    FieldConfig::create(["field_name"=>"field_cf_wid","entity_type"=>"node","bundle"=>"cf_eval","label"=>"Wid"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "cf_eval", "default");
  $fd->setComponent("field_cf_wid", [
    "type"=>"custom_flex","weight"=>20,"region"=>"content",
    "settings"=>["fields"=>["body"=>["type"=>"textarea"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cf_eval.field_cf_wid base widget custom_flex, body column widget textarea"
