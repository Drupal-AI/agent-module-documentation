#!/usr/bin/env bash
# Introspection SETUP: ensure a Local tax type cpt_eu_vat exists and attach a commerce_tax_rate
# field field_cpt_type to the 'default' product variation type bound to it, so the agent must
# inspect the live field settings to report which tax type the tax-rate field uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_tax\Entity\TaxType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!TaxType::load("cpt_eu_vat")) { TaxType::create(["id"=>"cpt_eu_vat","label"=>"CPT EU VAT","plugin"=>"european_union_vat","configuration"=>["display_inclusive"=>true]])->save(); }
  if (!FieldStorageConfig::loadByName("commerce_product_variation","field_cpt_type")) { FieldStorageConfig::create(["field_name"=>"field_cpt_type","entity_type"=>"commerce_product_variation","type"=>"commerce_tax_rate"])->save(); }
  if (!FieldConfig::loadByName("commerce_product_variation","default","field_cpt_type")) { FieldConfig::create(["field_name"=>"field_cpt_type","entity_type"=>"commerce_product_variation","bundle"=>"default","label"=>"Tax rate","settings"=>["tax_type"=>"cpt_eu_vat","allowed_zones"=>["de","fr"]]])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_cpt_type (commerce_tax_rate) on variation type default, tax_type=cpt_eu_vat"
