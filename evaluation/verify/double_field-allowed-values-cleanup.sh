#!/usr/bin/env bash
# Introspection CLEANUP: remove field_df_rating from Article (drops storage, instance and the
# form-display component along with the allowed-values list). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_rating")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_rating")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_df_rating removed from node.article"
