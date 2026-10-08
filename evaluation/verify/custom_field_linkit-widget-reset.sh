#!/usr/bin/env bash
# Execution RESET (custom_field_linkit): field_cf_lk with a link column "cta" but subfield widget
# set to the plain 'link_default' (NOT linkit). verify FAILs until agent selects linkit. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType; use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_lk_eval")) { NodeType::create(["type"=>"cf_lk_eval","name"=>"CF Linkit Eval"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_cf_lk")) {
    FieldStorageConfig::create(["field_name"=>"field_cf_lk","entity_type"=>"node","type"=>"custom","cardinality"=>1,
      "settings"=>["columns"=>["cta"=>["name"=>"cta","type"=>"link"]]]])->save(); }
  if (!FieldConfig::loadByName("node","cf_lk_eval","field_cf_lk")) {
    FieldConfig::create(["field_name"=>"field_cf_lk","entity_type"=>"node","bundle"=>"cf_lk_eval","label"=>"Links",
      "settings"=>["field_settings"=>["cta"=>["label"=>"CTA"]]]])->save(); }
  $s=\Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd=$s->load("node.cf_lk_eval.default") ?: $s->create(["targetEntityType"=>"node","bundle"=>"cf_lk_eval","mode"=>"default","status"=>true]);
  $fd->setComponent("field_cf_lk",["type"=>"custom_stacked","region"=>"content","weight"=>5,
    "settings"=>["fields"=>["cta"=>["type"=>"link_default","weight"=>0]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cf_lk cta uses link_default (not linkit)"
