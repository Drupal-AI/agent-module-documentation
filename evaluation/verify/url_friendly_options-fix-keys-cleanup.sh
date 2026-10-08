#!/usr/bin/env bash
# Execution CLEANUP: remove field_ufo_fix. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ufo_fix")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ufo_fix")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ufo_fix removed"
