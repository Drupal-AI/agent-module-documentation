#!/usr/bin/env bash
# Execution CLEANUP: remove field_oly_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_oly_task")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_oly_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_oly_task removed"
