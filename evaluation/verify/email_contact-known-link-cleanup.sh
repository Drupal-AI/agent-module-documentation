#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ec_known (drops its display component too). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_ec_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_ec_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ec_known removed"
