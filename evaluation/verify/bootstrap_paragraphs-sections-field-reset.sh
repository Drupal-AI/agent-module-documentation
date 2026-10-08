#!/usr/bin/env bash
# Execution RESET for "attach a Bootstrap Paragraphs sections field to Article".
# Removes field_bp_task_sections from node.article entirely so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bp_task_sections")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bp_task_sections")) { $fs->delete(); }
  field_purge_batch(200);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bp_task_sections removed from node.article"
