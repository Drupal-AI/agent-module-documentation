#!/usr/bin/env bash
# Execution CLEANUP: remove field_range_fee from Article (also drops its form/view display
# components). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_range_fee")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_range_fee")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_range_fee removed from node.article"
