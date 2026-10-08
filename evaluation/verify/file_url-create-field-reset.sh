#!/usr/bin/env bash
# Execution RESET: ensure NO field_fu_task exists on Article, so verify FAILs on empty state
# until the agent creates the file_url field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fu_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fu_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fu_task absent from node.article"
