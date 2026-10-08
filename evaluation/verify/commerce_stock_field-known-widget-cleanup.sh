#!/usr/bin/env bash
# Introspection CLEANUP: remove field_csf_stock (scoped to this field only). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("commerce_product_variation", "default", "field_csf_stock")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("commerce_product_variation", "field_csf_stock")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_csf_stock removed"
