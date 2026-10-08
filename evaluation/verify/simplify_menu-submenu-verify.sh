#!/usr/bin/env bash
# Live-state verification for the "nested menu" task: a parent link "Products" in the main
# menu with a child link "Widgets" under it. PASS when simplify_menu's service
# (getMenuTree('main')) returns a top-level item text="Products" that carries a 'submenu'
# array containing an item text="Widgets" — i.e. the module nested the child correctly.
# Rebuilds links + clears menu cache first. Prints PASS/FAIL with detail; exits 0/1.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  \Drupal::cache("menu")->deleteAll();
  $tree = \Drupal::service("simplify_menu.menu_items")->getMenuTree("main")["menu_tree"];
  $parent = FALSE; $child = FALSE;
  foreach ($tree as $item) {
    if ($item["text"] === "Products") {
      $parent = TRUE;
      if (!empty($item["submenu"])) {
        foreach ($item["submenu"] as $sub) {
          if ($sub["text"] === "Widgets") { $child = TRUE; }
        }
      }
    }
  }
  print (($parent && $child) ? "PASS" : "FAIL")
    . " parent=" . ($parent ? 1 : 0) . " child_in_submenu=" . ($child ? 1 : 0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
