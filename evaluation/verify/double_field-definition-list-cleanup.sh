#!/usr/bin/env bash
# Execution CLEANUP: remove field_df_faq from Article (drops storage, instance and both display
# components). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_df_faq")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_df_faq")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_df_faq removed from node.article"
