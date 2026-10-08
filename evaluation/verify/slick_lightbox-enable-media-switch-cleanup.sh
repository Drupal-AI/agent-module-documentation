#!/usr/bin/env bash
# Execution CLEANUP: remove the namespaced field_sl_image (drops its view-display component
# too), restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_sl_image")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_sl_image")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_sl_image removed from node.article"
