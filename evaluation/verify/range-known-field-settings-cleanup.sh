#!/usr/bin/env bash
# Introspection CLEANUP: remove field_range_price from Article (also drops its form-display
# component and range field settings). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_range_price")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_range_price")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_range_price removed from node.article"
