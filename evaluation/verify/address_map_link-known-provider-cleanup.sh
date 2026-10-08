#!/usr/bin/env bash
# Introspection CLEANUP: remove field_aml_known (drops its view-display component too). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_aml_known")) $fc->delete();
  if ($fs=FieldStorageConfig::loadByName("node","field_aml_known")) $fs->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_aml_known removed"
