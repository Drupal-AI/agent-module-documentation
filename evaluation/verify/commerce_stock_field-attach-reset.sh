#!/usr/bin/env bash
# Execution RESET: ensure field_csf_task does NOT exist on the default variation type, so verify
# FAILS until the agent attaches a commerce_stock_level field. Scoped delete. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("commerce_product_variation", "default", "field_csf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("commerce_product_variation", "field_csf_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_csf_task absent from commerce_product_variation.default"
