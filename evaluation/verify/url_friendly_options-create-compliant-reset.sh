#!/usr/bin/env bash
# Execution RESET: ensure field_ufo_task does NOT exist, so verify FAILS until the agent creates a
# URL-friendly-keyed options field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ufo_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ufo_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ufo_task removed"
