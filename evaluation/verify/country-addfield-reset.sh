#!/usr/bin/env bash
# Execution RESET: ensure field_ctry_task does NOT exist so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_ctry_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_ctry_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ctry_task absent from node.article"
