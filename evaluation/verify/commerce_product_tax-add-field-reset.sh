#!/usr/bin/env bash
# Execution RESET: ensure the Local tax type cpt_eu_vat exists but the field_cpt_task tax-rate
# field does NOT exist on the default variation type, so verify FAILS until the agent adds it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_tax\Entity\TaxType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!TaxType::load("cpt_eu_vat")) { TaxType::create(["id"=>"cpt_eu_vat","label"=>"CPT EU VAT","plugin"=>"european_union_vat","configuration"=>["display_inclusive"=>true]])->save(); }
  if ($fc = FieldConfig::loadByName("commerce_product_variation","default","field_cpt_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("commerce_product_variation","field_cpt_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cpt_eu_vat present, field_cpt_task absent from variation type default"
