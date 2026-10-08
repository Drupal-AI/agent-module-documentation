#!/usr/bin/env bash
# Execution CLEANUP: remove the tmui_depts vocabulary (and its terms) and the
# tmui_depts_menu menu (and its links). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($mlc->loadByProperties(["menu_name" => "tmui_depts_menu"]) as $l) { $l->delete(); }
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($ts->loadByProperties(["vid" => "tmui_depts"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("tmui_depts")) { $v->delete(); }
  if ($m = Menu::load("tmui_depts_menu")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmui_depts vocabulary and tmui_depts_menu removed"
