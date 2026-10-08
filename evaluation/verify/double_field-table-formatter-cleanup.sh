#!/usr/bin/env bash
# Introspection CLEANUP: remove field_df_hours from Article (drops storage, instance and both
# display components including the double_field_table settings). Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_hours")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_hours")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_df_hours removed from node.article"
