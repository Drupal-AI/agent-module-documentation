#!/usr/bin/env bash
# Execution RESET: ensure field_lf_task does NOT exist on Article, so verify FAILS until the
# agent adds a language_field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_lf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_lf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_lf_task absent from node.article"
