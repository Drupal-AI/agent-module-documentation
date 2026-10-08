#!/usr/bin/env bash
# Execution CLEANUP: remove field_interval_task from Article. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_interval_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_interval_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_interval_task removed from node.article"
