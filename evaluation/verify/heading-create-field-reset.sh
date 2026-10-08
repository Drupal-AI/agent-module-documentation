#!/usr/bin/env bash
# Execution RESET: ensure the heading field field_hdg_task does NOT exist on Article, so verify
# FAILS until the agent creates it as a 'heading' field type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_hdg_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_hdg_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_hdg_task absent from Article"
