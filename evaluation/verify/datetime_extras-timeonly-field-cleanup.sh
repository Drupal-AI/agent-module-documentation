#!/usr/bin/env bash
# Execution CLEANUP: remove field_dte_time from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_dte_time")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dte_time")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dte_time removed"
