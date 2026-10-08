#!/usr/bin/env bash
# Execution RESET: ensure field_ccs_custom is absent so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_ccs_custom")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_ccs_custom")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ccs_custom absent"
