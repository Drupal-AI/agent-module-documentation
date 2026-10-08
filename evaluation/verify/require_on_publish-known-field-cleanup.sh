#!/usr/bin/env bash
# Introspection CLEANUP: remove field_rop_known from Article. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_rop_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_rop_known")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_rop_known removed from node.article"
