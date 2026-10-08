#!/usr/bin/env bash
# Introspection CLEANUP: remove the field_provus_menu_callout_link field/storage (scoped by
# name, provus-owned only). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("menu_link_content", "main", "field_provus_menu_callout_link")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("menu_link_content", "field_provus_menu_callout_link")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_provus_menu_callout_link removed from menu_link_content"
