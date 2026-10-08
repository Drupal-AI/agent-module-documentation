#!/usr/bin/env bash
# Execution CLEANUP: remove the field_erim_img field created for this case (drops its component). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_erim_img")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_erim_img")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_erim_img removed"
