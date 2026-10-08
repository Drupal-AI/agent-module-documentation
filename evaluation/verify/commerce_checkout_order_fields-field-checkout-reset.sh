#!/usr/bin/env bash
# Execution RESET: remove the field_ccof_note field from the commerce_order 'default' order type
# (and its checkout form-display component), so the verify FAILS until the agent creates it and
# enables it on the Checkout form display. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("commerce_order", "default", "field_ccof_note")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("commerce_order", "field_ccof_note")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_ccof_note removed from commerce_order.default"
