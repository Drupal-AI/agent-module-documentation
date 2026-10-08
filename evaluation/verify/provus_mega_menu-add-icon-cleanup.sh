#!/usr/bin/env bash
# Execution CLEANUP: remove field_provus_menu_icon field/storage (scoped by name). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("menu_link_content", "main", "field_provus_menu_icon")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("menu_link_content", "field_provus_menu_icon")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_provus_menu_icon removed from menu_link_content"
