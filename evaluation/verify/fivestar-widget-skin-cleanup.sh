#!/usr/bin/env bash
# Introspection CLEANUP: remove field_fs_skin from Article (also drops its display component).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fs_skin")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fs_skin")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fs_skin removed from node.article"
