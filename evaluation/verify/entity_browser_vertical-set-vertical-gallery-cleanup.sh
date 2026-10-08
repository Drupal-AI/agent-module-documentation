#!/usr/bin/env bash
# Execution CLEANUP (entity_browser_vertical, layman): remove field_ebv_gallery. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ebv_gallery")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ebv_gallery")) { $fs->delete(); }
' >/dev/null 2>&1 || true
echo "cleanup: field_ebv_gallery removed"
exit 0
