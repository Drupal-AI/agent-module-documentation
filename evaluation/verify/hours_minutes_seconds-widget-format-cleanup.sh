#!/usr/bin/env bash
# Introspection CLEANUP (hours_minutes_seconds): remove field_hms_fmt. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_hms_fmt")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_hms_fmt")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_hms_fmt removed"
