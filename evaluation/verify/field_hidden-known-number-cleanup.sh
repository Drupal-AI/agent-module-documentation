#!/usr/bin/env bash
# Introspection CLEANUP: remove field_fh_count. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fh_count")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fh_count")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_fh_count removed from node.article"
