#!/usr/bin/env bash
# Execution VERIFY: PASS when menu md_task still EXISTS but has ZERO content menu_link_content
# links (all bulk-deleted). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\system\Entity\Menu;
  $menu = Menu::load("md_task");
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $count = (int) $storage->getQuery()->accessCheck(FALSE)->condition("menu_name","md_task")->count()->execute();
  $ok = ($menu !== NULL) && ($count === 0);
  print ($ok ? "PASS" : "FAIL") . " menu=" . ($menu ? "yes" : "no") . " links=" . $count . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
