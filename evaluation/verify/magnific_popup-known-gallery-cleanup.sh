#!/usr/bin/env bash
# Introspection CLEANUP: remove field_mfp_gal (also drops its display component). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_mfp_gal")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_mfp_gal")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mfp_gal removed"
