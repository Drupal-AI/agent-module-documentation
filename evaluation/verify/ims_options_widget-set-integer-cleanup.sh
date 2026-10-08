#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_imsw_pri")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_imsw_pri")) { $fs->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_imsw_pri removed"
