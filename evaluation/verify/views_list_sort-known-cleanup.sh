#!/usr/bin/env bash
# Introspection CLEANUP: remove vls_known_view and field_vls_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if ($v = View::load("vls_known_view")) { $v->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_vls_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_vls_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vls_known_view and field_vls_known removed"
