#!/usr/bin/env bash
# Introspection CLEANUP: remove field_cmv_gallery from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_cmv_gallery")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_cmv_gallery")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cmv_gallery removed from node.article"
