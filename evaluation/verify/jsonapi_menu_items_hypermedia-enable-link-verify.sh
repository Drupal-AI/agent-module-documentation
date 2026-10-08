#!/usr/bin/env bash
# Execution VERIFY: PASS when the jsonapi_menu_items endpoint for menu jmih_edit (the target of the
# hypermedia submodule's menu_items--jmih_edit link) would return a link titled 'JMIH Toggle'. Uses the same
# menu.link_tree + manipulators the resource uses. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Menu\MenuTreeParameters;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("jmih_edit")) { print "FAIL menu=missing\n"; return; }
  $svc = \Drupal::service("menu.link_tree");
  $p = new MenuTreeParameters(); $p->onlyEnabledLinks();
  $tree = $svc->load("jmih_edit", $p);
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
  $ok = in_array("JMIH Toggle", $titles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " titles=" . implode("|", $titles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
