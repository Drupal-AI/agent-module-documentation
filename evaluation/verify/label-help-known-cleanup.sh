#!/usr/bin/env bash
# Introspection CLEANUP: delete field_lh_known storage (removes the instance + its label help). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fs = FieldStorageConfig::loadByName("node", "field_lh_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_lh_known removed"
