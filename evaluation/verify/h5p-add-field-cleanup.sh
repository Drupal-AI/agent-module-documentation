#!/usr/bin/env bash
# Execution CLEANUP: remove field_h5p_task to leave the site clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_h5p_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_h5p_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_h5p_task removed"
