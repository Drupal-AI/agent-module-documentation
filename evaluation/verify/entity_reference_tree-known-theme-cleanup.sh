#!/usr/bin/env bash
# medium CLEANUP (entity_reference_tree): remove field_ert_theme. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ert_theme")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ert_theme")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_ert_theme removed"
