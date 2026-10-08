#!/usr/bin/env bash
# Execution CLEANUP: remove the built view and the daterange field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if ($v = View::load("vdf_build")) { $v->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_vdf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_vdf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vdf_build and field_vdf_task removed"
