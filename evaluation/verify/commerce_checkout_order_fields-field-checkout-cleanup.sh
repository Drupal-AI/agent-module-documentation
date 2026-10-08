#!/usr/bin/env bash
# Execution CLEANUP: remove the field_ccof_note field from commerce_order.default (baseline).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("commerce_order", "default", "field_ccof_note")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("commerce_order", "field_ccof_note")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_ccof_note removed from commerce_order.default"
