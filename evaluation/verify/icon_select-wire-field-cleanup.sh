#!/usr/bin/env bash
# Execution CLEANUP: remove field_is_task_icon from Article (drops its storage + display
# components). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_is_task_icon")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_is_task_icon")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_is_task_icon removed from node.article"
