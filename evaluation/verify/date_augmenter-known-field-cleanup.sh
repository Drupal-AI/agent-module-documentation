#!/usr/bin/env bash
# Delete field_da_known (also drops the view-display component + date_augmenter setting). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_da_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_da_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_da_known removed"
