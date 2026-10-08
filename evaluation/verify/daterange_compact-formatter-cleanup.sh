#!/usr/bin/env bash
# Execution CLEANUP (daterange_compact formatter): remove field_dc_range. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_dc_range")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_dc_range")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dc_range removed"
