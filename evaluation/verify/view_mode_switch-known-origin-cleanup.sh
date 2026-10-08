#!/usr/bin/env bash
# Introspection CLEANUP: remove field_vms. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_vms")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_vms")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_vms removed"
