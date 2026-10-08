#!/usr/bin/env bash
# Execution CLEANUP: remove field_mif_task from menu_link_content. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("menu_link_content", "menu_link_content", "field_mif_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("menu_link_content", "field_mif_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_mif_task removed"
