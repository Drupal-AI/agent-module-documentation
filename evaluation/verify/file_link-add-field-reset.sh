#!/usr/bin/env bash
# Execution RESET: delete field_flink_task from Article if present, so verify FAILS on empty
# state until the agent creates a file_link field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_flink_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_flink_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_flink_task removed from node.article"
