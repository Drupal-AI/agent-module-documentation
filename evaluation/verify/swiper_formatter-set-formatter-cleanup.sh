#!/usr/bin/env bash
# Execution CLEANUP: remove field_sf_txt (drops its display component). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_sf_txt")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_sf_txt")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_sf_txt removed"
