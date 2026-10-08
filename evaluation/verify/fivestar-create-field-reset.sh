#!/usr/bin/env bash
# Execution RESET: ensure the fivestar field field_fs_task does NOT exist on Article, so the
# verify script FAILS until the agent creates it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fs_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fs_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fs_task absent from node.article"
