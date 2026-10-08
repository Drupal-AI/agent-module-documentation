#!/usr/bin/env bash
# Execution CLEANUP: remove field_idf_shots. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_idf_shots")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_idf_shots")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_idf_shots removed from node.article"
