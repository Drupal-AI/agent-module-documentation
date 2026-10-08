#!/usr/bin/env bash
# Execution RESET: ensure Article has NO field_atc_btn, so verify FAILS on empty state until the
# agent adds a field of the module's add_to_calendar_field type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_atc_btn")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_atc_btn")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_atc_btn absent"
