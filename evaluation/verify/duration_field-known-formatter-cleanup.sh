#!/usr/bin/env bash
# Introspection CLEANUP: remove field_df_disp and its storage (also drops the display component).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_disp")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_disp")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_df_disp removed"
