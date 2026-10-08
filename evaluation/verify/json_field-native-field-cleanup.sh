#!/usr/bin/env bash
# Execution CLEANUP: same as reset - drop field_jf_task from node.article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_jf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_jf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_jf_task removed from node.article"
