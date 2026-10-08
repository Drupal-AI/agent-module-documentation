#!/usr/bin/env bash
# Introspection SETUP (custom_field_linkit): content type cf_lk_eval + Custom Field field_cf_lk
# with a link column "cta" whose subfield widget is the Linkit widget 'linkit'. Idempotent. Exit 0.
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
    "settings"=>["fields"=>["cta"=>["type"=>"linkit","weight"=>0,"linkit_profile"=>"default"]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cf_lk_eval/field_cf_lk link column cta uses linkit widget"
