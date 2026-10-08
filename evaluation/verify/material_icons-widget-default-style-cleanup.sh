#!/usr/bin/env bash
# Introspection CLEANUP: remove field_mi_known (drops its form-display component too), restoring
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_mi_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mi_known")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_mi_known removed from node.article"
