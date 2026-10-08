#!/usr/bin/env bash
# Execution RESET: ensure the duration field field_df_period does NOT exist on Article, so
# verify FAILS until the agent creates and configures it. Idempotent. Exit 0.
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
echo "reset: field_df_period absent"
