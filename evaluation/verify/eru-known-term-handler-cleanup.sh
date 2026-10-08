#!/usr/bin/env bash
# CLEANUP: delete field_eru_terms (namespaced). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_eru_terms")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_eru_terms")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_eru_terms removed"
