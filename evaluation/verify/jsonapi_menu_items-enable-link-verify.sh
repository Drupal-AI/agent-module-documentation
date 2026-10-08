#!/usr/bin/env bash
# Execution VERIFY: PASS when the jsonapi_menu_items resource for menu jmi_edit would return the
# link 'Toggle Link' (i.e. it is now enabled + accessible). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Menu\MenuTreeParameters;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("jmi_edit")) { print "FAIL menu=missing\n"; return; }
  $svc = \Drupal::service("menu.link_tree");
  $p = new MenuTreeParameters(); $p->onlyEnabledLinks();
  $tree = $svc->load("jmi_edit", $p);
  $tree = $svc->transform($tree, [
    ["callable" => "menu.default_tree_manipulators:checkAccess"],
    ["callable" => "menu.default_tree_manipulators:generateIndexAndSort"],
  ]);
  $titles = [];
  $stack = array_values($tree);
  while ($stack) {
    $e = array_shift($stack);
    if ($e->access !== NULL && !$e->access->isAllowed()) { continue; }
    $titles[] = (string) $e->link->getTitle();
    if ($e->subtree) { foreach ($e->subtree as $s) { $stack[] = $s; } }
  }
  $ok = in_array("Toggle Link", $titles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " titles=" . implode("|", $titles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
