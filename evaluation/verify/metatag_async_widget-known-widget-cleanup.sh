#!/usr/bin/env bash
# Introspection CLEANUP: remove field_maw_meta from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_maw_meta")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_maw_meta")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_maw_meta removed"
