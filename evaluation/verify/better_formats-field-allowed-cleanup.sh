#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bf_med")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bf_med")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed field_bf_med"
