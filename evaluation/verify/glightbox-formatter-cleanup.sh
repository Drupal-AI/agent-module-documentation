#!/usr/bin/env bash
# Introspection CLEANUP: remove field_glb_img (drops its display component too).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_glb_img")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_glb_img")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_glb_img removed"
