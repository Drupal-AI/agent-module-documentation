#!/usr/bin/env bash
# Execution CLEANUP: delete field_lfw_single. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_lfw_single")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_lfw_single")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_lfw_single removed"
