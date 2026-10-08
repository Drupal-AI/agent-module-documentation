#!/usr/bin/env bash
# Execution RESET: ensure tax type cpt_eu_vat and a commerce_tax_rate field field_cpt_zones on
# the default variation type with EMPTY allowed_zones, so verify FAILS until the agent restricts
# it to the Germany (de) zone. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_tax\Entity\TaxType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!TaxType::load("cpt_eu_vat")) { TaxType::create(["id"=>"cpt_eu_vat","label"=>"CPT EU VAT","plugin"=>"european_union_vat","configuration"=>["display_inclusive"=>true]])->save(); }
  if (!FieldStorageConfig::loadByName("commerce_product_variation","field_cpt_zones")) { FieldStorageConfig::create(["field_name"=>"field_cpt_zones","entity_type"=>"commerce_product_variation","type"=>"commerce_tax_rate"])->save(); }
  $fc = FieldConfig::loadByName("commerce_product_variation","default","field_cpt_zones");
  if (!$fc) { $fc = FieldConfig::create(["field_name"=>"field_cpt_zones","entity_type"=>"commerce_product_variation","bundle"=>"default","label"=>"Tax rate"]); }
  $fc->setSetting("tax_type","cpt_eu_vat")->setSetting("allowed_zones",[])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cpt_zones present with empty allowed_zones"
