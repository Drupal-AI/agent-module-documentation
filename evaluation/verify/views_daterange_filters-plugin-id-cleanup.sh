#!/usr/bin/env bash
# Introspection CLEANUP: delete the view and daterange field created by the matching setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if ($v = View::load("vdf_m2_ends")) { $v->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_vdf_m2")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_vdf_m2")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vdf_m2_ends and field_vdf_m2 removed"
