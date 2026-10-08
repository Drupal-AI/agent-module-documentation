#!/usr/bin/env bash
# Execution RESET: ensure field_mif_task is ABSENT on menu_link_content so verify FAILS until
# the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("menu_link_content", "menu_link_content", "field_mif_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("menu_link_content", "field_mif_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_mif_task absent on menu_link_content"
