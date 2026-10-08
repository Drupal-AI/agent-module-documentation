#!/usr/bin/env bash
# Execution CLEANUP: remove mif_hero view mode + display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("menu_link_content.menu_link_content.mif_hero")) { $vd->delete(); }
  if ($vm = \Drupal::entityTypeManager()->getStorage("entity_view_mode")->load("menu_link_content.mif_hero")) { $vm->delete(); }
' >/dev/null 2>&1
echo "cleanup: mif_hero removed"
