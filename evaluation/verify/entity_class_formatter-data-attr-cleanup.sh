#!/usr/bin/env bash
# Execution CLEANUP: remove field_ecf_cols from Article. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ecf_cols")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ecf_cols")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ecf_cols removed from node.article"
