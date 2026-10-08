#!/usr/bin/env bash
# Execution CLEANUP: remove field_tff_task2 (drops its view-display component). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_tff_task2")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_tff_task2")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_tff_task2 removed"
