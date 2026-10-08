#!/usr/bin/env bash
# Execution RESET: field_aml_store (address) present with the address_default formatter and
# address_map_link link_address FALSE (so verify FAILS until the agent links it to Apple Maps).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_aml_store")) {
    FieldStorageConfig::create(["field_name"=>"field_aml_store","entity_type"=>"node","type"=>"address"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_aml_store")) {
    FieldConfig::create(["field_name"=>"field_aml_store","entity_type"=>"node","bundle"=>"article","label"=>"Store"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_aml_store", ["type"=>"address_default","weight"=>63,"region"=>"content",
    "third_party_settings"=>["address_map_link"=>["link_address"=>FALSE]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_aml_store present, link_address=FALSE"
