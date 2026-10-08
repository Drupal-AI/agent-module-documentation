#!/usr/bin/env bash
# Execution CLEANUP: remove field_veh_video (storage + config) from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_veh_video")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_veh_video")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_veh_video removed from node.article"
