#!/usr/bin/env bash
# Introspection CLEANUP: delete only the field_straw_known field created by setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_straw_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_straw_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_straw_known removed"
