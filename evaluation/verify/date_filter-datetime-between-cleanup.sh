#!/usr/bin/env bash
# Execution CLEANUP: remove the view and the Date/time field used by the datetime-between
# case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if ($v = View::load("date_filter_build")) { $v->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_build")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_build")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.date_filter_build and field_df_build removed"
