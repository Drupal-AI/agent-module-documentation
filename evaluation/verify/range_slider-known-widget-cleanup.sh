#!/usr/bin/env bash
# Introspection CLEANUP: remove field_rs_known (own field only). Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_rs_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_rs_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_rs_known removed"
