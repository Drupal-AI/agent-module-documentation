#!/usr/bin/env bash
# Execution CLEANUP (tzfield create): remove field_tz_new. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_tz_new")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_tz_new")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_tz_new removed"
