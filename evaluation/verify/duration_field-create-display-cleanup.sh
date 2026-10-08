#!/usr/bin/env bash
# Execution CLEANUP: remove field_df_period, storage, and its view display component.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_period")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_period")) { $fs->delete(); }
  \Drupal::service("entity_display.repository")->getViewDisplay("node", "article")->removeComponent("field_df_period")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_df_period removed"
