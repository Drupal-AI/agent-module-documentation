#!/usr/bin/env bash
# Execution CLEANUP: remove the field_mdb_assets field created by the reset script (which
# also drops its form-display component). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_mdb_assets")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mdb_assets")) { $fs->delete(); }
' >/dev/null 2>&1

echo "cleanup: field_mdb_assets removed from node.article"
