#!/usr/bin/env bash
# Introspection CLEANUP: delete every menu_link_content in tmui_nav, the tmui_regions terms
# and vocabulary, and the tmui_nav menu. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($mlc->loadByProperties(["menu_name" => "tmui_nav"]) as $l) { $l->delete(); }
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($ts->loadByProperties(["vid" => "tmui_regions"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("tmui_regions")) { $v->delete(); }
  if ($m = Menu::load("tmui_nav")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmui_nav links, tmui_regions terms/vocabulary and tmui_nav menu removed"
