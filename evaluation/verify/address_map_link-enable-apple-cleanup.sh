#!/usr/bin/env bash
# Execution CLEANUP: remove field_aml_store. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_aml_store")) $fc->delete();
  if ($fs=FieldStorageConfig::loadByName("node","field_aml_store")) $fs->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_aml_store removed"
