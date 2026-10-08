#!/usr/bin/env bash
# Execution CLEANUP: remove field_fh_score. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fh_score")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fh_score")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_fh_score removed from node.article"
