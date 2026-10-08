#!/usr/bin/env bash
# Execution RESET: ensure cf_eval + Custom Field field_cf_disp exist, and force its default
# form-display base widget to custom_stacked (so verify FAILS until switched to custom_flex).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_eval")) { NodeType::create(["type"=>"cf_eval","name"=>"CF Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_cf_disp")) {
    FieldStorageConfig::create([
      "field_name"=>"field_cf_disp","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["value"=>["name"=>"value","type"=>"string","max_length"=>255]]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "cf_eval", "field_cf_disp")) {
    FieldConfig::create(["field_name"=>"field_cf_disp","entity_type"=>"node","bundle"=>"cf_eval","label"=>"Disp"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "cf_eval", "default");
  $fd->setComponent("field_cf_disp", [
    "type"=>"custom_stacked","weight"=>25,"region"=>"content",
    "settings"=>["fields"=>["value"=>["type"=>"text"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cf_eval.field_cf_disp base widget forced to custom_stacked"
