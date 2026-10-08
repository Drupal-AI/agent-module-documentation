#!/usr/bin/env bash
# Execution RESET: ensure the H5P field field_h5p_task does NOT exist on Article so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_h5p_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_h5p_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_h5p_task absent from node.article"
