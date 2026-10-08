#!/usr/bin/env bash
# Execution CLEANUP (insert_media): remove field_insert_mtask. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_insert_mtask")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_insert_mtask")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_insert_mtask removed from node.article"
