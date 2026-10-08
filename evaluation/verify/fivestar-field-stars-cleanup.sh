#!/usr/bin/env bash
# Introspection CLEANUP: remove field_fs_known from Article (drops the field config + storage).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fs_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fs_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fs_known removed from node.article"
