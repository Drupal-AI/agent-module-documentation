#!/usr/bin/env bash
# Introspection CLEANUP: remove field_bps_img from Article (drops its view-display component).
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bps_img")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bps_img")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_bps_img removed from node.article"
