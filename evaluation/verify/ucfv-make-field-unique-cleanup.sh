#!/usr/bin/env bash
# Execution CLEANUP: delete field_ucfv_code from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ucfv_code")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ucfv_code")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_ucfv_code removed from node.article"
