#!/usr/bin/env bash
# Introspection CLEANUP: remove field_df_specs from Article (drops the field storage, the
# instance and the form-display component). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_specs")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_specs")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_df_specs removed from node.article"
