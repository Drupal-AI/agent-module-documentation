#!/usr/bin/env bash
# Execution RESET: ensure NO field_kvf_task exists on Article, so verify FAILS until the
# agent creates the key_value field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_kvf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_kvf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_kvf_task absent from node.article"
