#!/usr/bin/env bash
# Introspection CLEANUP: delete the tmui_products vocabulary and the tmui_catalog menu
# created by the matching setup (which removes the taxonomy_menu_ui third-party settings
# with them). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  if ($v = Vocabulary::load("tmui_products")) { $v->delete(); }
  if ($m = Menu::load("tmui_catalog")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vocabulary tmui_products and menu tmui_catalog removed"
