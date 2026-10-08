#!/usr/bin/env bash
# Introspection CLEANUP: remove field_oly_mb. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_oly_mb")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_oly_mb")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_oly_mb removed"
