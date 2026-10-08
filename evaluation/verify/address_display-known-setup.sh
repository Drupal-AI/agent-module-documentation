#!/usr/bin/env bash
# Introspection SETUP: create an address field field_addisp_addr on Article and configure its
# default view display to use the address_display_formatter showing ONLY locality and country_code.
# Lets an agent read back the formatter and which components display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_addisp_addr")) {
    FieldStorageConfig::create(["field_name"=>"field_addisp_addr","entity_type"=>"node","type"=>"address"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_addisp_addr")) {
    FieldConfig::create(["field_name"=>"field_addisp_addr","entity_type"=>"node","bundle"=>"article","label"=>"Addisp Address"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_addisp_addr", [
    "type"=>"address_display_formatter","label"=>"hidden","region"=>"content","weight"=>60,
    "settings"=>["address_display"=>[
      "locality"=>["display"=>TRUE,"glue"=>", ","weight"=>0],
      "country_code"=>["display"=>TRUE,"glue"=>"","weight"=>1],
      "postal_code"=>["display"=>FALSE,"glue"=>"","weight"=>2],
      "address_line1"=>["display"=>FALSE,"glue"=>"","weight"=>3],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_addisp_addr uses address_display_formatter (locality + country_code shown)"
