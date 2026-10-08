#!/usr/bin/env bash
# Execution RESET: ensure field_cf_task does NOT exist, so verify FAILS until the agent creates it.
# Deletes only this fixture field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_cf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_cf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cf_task absent"
