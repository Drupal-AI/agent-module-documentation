#!/usr/bin/env bash
# Introspection SETUP: add entity_reference field field_ieftvm_m1 to Article and set its default
# form-display widget to inline_entity_form_complex_table_view_mode so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ieftvm_m1")) {
    FieldStorageConfig::create(["field_name"=>"field_ieftvm_m1","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ieftvm_m1")) {
    FieldConfig::create(["field_name"=>"field_ieftvm_m1","entity_type"=>"node","bundle"=>"article","label"=>"IEF M1 Ref"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ieftvm_m1", ["type"=>"inline_entity_form_complex_table_view_mode","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ieftvm_m1 on node.article.default uses inline_entity_form_complex_table_view_mode"
