#!/usr/bin/env bash
# Introspection CLEANUP: remove field_cpt_zone and the cpt_eu_vat tax type. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_tax\Entity\TaxType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("commerce_product_variation","default","field_cpt_zone")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("commerce_product_variation","field_cpt_zone")) { $fs->delete(); }
  if ($t = TaxType::load("cpt_eu_vat")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cpt_zone and cpt_eu_vat removed"
