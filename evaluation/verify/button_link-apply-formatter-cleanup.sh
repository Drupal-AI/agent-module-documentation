#!/usr/bin/env bash
# Execution CLEANUP: remove field_btl_task. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_btl_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_btl_task")) { $fs->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_btl_task removed from node.article"
