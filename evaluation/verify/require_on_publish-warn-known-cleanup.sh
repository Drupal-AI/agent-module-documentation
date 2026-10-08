#!/usr/bin/env bash
# Introspection CLEANUP: remove field_rop_warn from Article. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_rop_warn")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_rop_warn")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_rop_warn removed from node.article"
