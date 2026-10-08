#!/usr/bin/env bash
# Introspection CLEANUP: remove mif_mega view mode + display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("menu_link_content.menu_link_content.mif_mega")) { $vd->delete(); }
  if ($vm = \Drupal::entityTypeManager()->getStorage("entity_view_mode")->load("menu_link_content.mif_mega")) { $vm->delete(); }
' >/dev/null 2>&1
echo "cleanup: mif_mega removed"
