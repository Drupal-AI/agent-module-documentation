#!/usr/bin/env bash
# Introspection CLEANUP: remove field_range_span from Article, which also drops its
# form-display component and the range widget label/placeholder settings.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_range_span")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_range_span")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_range_span removed from node.article"
