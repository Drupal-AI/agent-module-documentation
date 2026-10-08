#!/usr/bin/env bash
# Execution CLEANUP: remove field_eabrf_task from Article (restores baseline).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_eabrf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_eabrf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_eabrf_task removed from node.article"
