#!/usr/bin/env bash
# Introspection SETUP: ensure tax type cpt_eu_vat and attach a commerce_tax_rate field
# field_cpt_zone whose allowed_zones are Germany (de) and France (fr), so the agent must inspect
# the live field settings to report which zones are allowed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_tax\Entity\TaxType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!TaxType::load("cpt_eu_vat")) { TaxType::create(["id"=>"cpt_eu_vat","label"=>"CPT EU VAT","plugin"=>"european_union_vat","configuration"=>["display_inclusive"=>true]])->save(); }
  if (!FieldStorageConfig::loadByName("commerce_product_variation","field_cpt_zone")) { FieldStorageConfig::create(["field_name"=>"field_cpt_zone","entity_type"=>"commerce_product_variation","type"=>"commerce_tax_rate"])->save(); }
  if (!FieldConfig::loadByName("commerce_product_variation","default","field_cpt_zone")) { FieldConfig::create(["field_name"=>"field_cpt_zone","entity_type"=>"commerce_product_variation","bundle"=>"default","label"=>"Tax rate","settings"=>["tax_type"=>"cpt_eu_vat","allowed_zones"=>["de","fr"]]])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_cpt_zone allowed_zones=[de,fr] on variation type default"
