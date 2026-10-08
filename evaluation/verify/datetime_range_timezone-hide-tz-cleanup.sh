#!/usr/bin/env bash
# Execution CLEANUP: remove field_drt_disp from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_drt_disp")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_drt_disp")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_drt_disp removed from node.article"
