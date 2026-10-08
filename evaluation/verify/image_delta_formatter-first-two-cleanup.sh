#!/usr/bin/env bash
# Execution CLEANUP: remove field_idf_lead. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_idf_lead")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_idf_lead")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_idf_lead removed from node.article"
