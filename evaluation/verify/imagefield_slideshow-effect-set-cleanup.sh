#!/usr/bin/env bash
# Execution CLEANUP: remove field_ifs_effect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_ifs_effect")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_ifs_effect")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ifs_effect removed"
