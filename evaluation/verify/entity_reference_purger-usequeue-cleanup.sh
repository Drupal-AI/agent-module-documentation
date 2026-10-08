#!/usr/bin/env bash
# Execution CLEANUP: remove field_erp_qtask. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_erp_qtask")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_erp_qtask")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_erp_qtask removed"
