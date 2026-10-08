#!/usr/bin/env bash
# Introspection CLEANUP (field_menu): remove field_fmenu_known from Article, restoring baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fmenu_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fmenu_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fmenu_known removed from node.article"
