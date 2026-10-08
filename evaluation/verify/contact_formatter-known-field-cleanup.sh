#!/usr/bin/env bash
# Cleanup for the known-field introspection case: remove field_cfmt_known.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fs = FieldStorageConfig::loadByName("node", "field_cfmt_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_cfmt_known removed"
