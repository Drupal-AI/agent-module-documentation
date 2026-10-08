#!/usr/bin/env bash
# Execution RESET: ensure field_gmf_task does NOT exist (verify must fail on empty state).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_gmf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_gmf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_gmf_task removed from node.article"
