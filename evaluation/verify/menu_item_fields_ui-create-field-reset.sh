#!/usr/bin/env bash
# Execution RESET: ensure field_miu_task ABSENT on menu_link_content so verify FAILS until added.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("menu_link_content", "menu_link_content", "field_miu_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("menu_link_content", "field_miu_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_miu_task absent"
