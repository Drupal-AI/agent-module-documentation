#!/usr/bin/env bash
# Execution CLEANUP: remove the tmui_events vocabulary and the tmui_events_menu menu.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($mlc->loadByProperties(["menu_name" => "tmui_events_menu"]) as $l) { $l->delete(); }
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($ts->loadByProperties(["vid" => "tmui_events"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("tmui_events")) { $v->delete(); }
  if ($m = Menu::load("tmui_events_menu")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmui_events vocabulary and tmui_events_menu removed"
