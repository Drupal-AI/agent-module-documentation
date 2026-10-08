#!/usr/bin/env bash
# Execution CLEANUP: remove field_fs_task from Article (leave the site clean).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fs_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fs_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fs_task removed from node.article"
