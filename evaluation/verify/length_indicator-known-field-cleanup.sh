#!/usr/bin/env bash
# Cleanup for known-field: remove field_li_known from Article.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_li_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_li_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_li_known removed"
