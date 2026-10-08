#!/usr/bin/env bash
# Introspection CLEANUP: remove field_oel_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_oel_known")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_oel_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_oel_known removed"
