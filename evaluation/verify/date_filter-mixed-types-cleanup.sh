#!/usr/bin/env bash
# Introspection CLEANUP: remove the mixed view and the Date/time field it used.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if ($v = View::load("date_filter_mixed")) { $v->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_moment")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_moment")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.date_filter_mixed and field_df_moment removed"
