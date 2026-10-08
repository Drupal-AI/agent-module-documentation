#!/usr/bin/env bash
# Execution CLEANUP: remove field_maw_task2 from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_maw_task2")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_maw_task2")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_maw_task2 removed"
