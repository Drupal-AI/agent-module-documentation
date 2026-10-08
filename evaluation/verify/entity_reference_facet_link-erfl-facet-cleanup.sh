#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article","field_erfl_ref2")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_erfl_ref2")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_erfl_ref2 removed"
