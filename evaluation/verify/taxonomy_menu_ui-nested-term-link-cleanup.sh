#!/usr/bin/env bash
# Execution CLEANUP: remove the tmui_shop vocabulary (and its terms) and the tmui_shop_menu
# menu (and all its links). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($mlc->loadByProperties(["menu_name" => "tmui_shop_menu"]) as $l) { $l->delete(); }
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($ts->loadByProperties(["vid" => "tmui_shop"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("tmui_shop")) { $v->delete(); }
  if ($m = Menu::load("tmui_shop_menu")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmui_shop vocabulary and tmui_shop_menu removed"
