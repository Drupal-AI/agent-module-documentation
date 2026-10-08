#!/usr/bin/env bash
# Introspection CLEANUP: remove field_interval_periods (drops its form-display component and
# widget settings). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_interval_periods")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_interval_periods")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_interval_periods removed from node.article"
