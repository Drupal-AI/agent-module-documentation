#!/usr/bin/env bash
# Introspection CLEANUP: remove the tmui_active / tmui_locked vocabularies and the tmui_side
# menu created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  foreach (["tmui_active", "tmui_locked"] as $vid) {
    if ($v = Vocabulary::load($vid)) { $v->delete(); }
  }
  if ($m = Menu::load("tmui_side")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmui_active, tmui_locked and menu tmui_side removed"
