#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ftv_known (also drops its display component). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ftv_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ftv_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ftv_known removed from node.article"
