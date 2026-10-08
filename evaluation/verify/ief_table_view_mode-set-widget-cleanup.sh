#!/usr/bin/env bash
# Execution CLEANUP: remove field_ieftvm_h1.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_ieftvm_h1")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_ieftvm_h1")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ieftvm_h1 removed"
