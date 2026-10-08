#!/usr/bin/env bash
# Execution RESET: ensure the per-item icon field (field_provus_menu_icon) is ABSENT from
# menu_link_content, so verify FAILS until the agent adds it. Scoped delete by name.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("menu_link_content", "main", "field_provus_menu_icon")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("menu_link_content", "field_provus_menu_icon")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_provus_menu_icon absent from menu_link_content"
