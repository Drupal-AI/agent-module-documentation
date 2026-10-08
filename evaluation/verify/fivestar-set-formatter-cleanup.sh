#!/usr/bin/env bash
# Execution CLEANUP: remove field_fs_display from Article (also drops its display component).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fs_display")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fs_display")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fs_display removed from node.article"
