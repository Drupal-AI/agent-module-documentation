#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ert_fmt from Article. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ert_fmt")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ert_fmt")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ert_fmt removed"
