#!/usr/bin/env bash
# Execution RESET: ensure NO field_drt_task exists on Article, so verify FAILs until the agent
# creates the daterange_timezone field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_drt_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_drt_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_drt_task absent from node.article"
