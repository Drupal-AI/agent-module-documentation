#!/usr/bin/env bash
# Live-state verification for the "add a 'Docs Home' link to the main menu" task.
# PASS when simplify_menu's own service (simplify_menu.menu_items::getMenuTree('main'))
# returns a link with text "Docs Home" pointing at the front page ('/').
# Rebuilds menu links + clears the menu cache first so a just-created link is visible even if
# the agent forgot to clear caches. Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  \Drupal::cache("menu")->deleteAll();
  $tree = \Drupal::service("simplify_menu.menu_items")->getMenuTree("main")["menu_tree"];
  $found = FALSE; $url = "";
  foreach ($tree as $item) {
    if ($item["text"] === "Docs Home") { $found = TRUE; $url = $item["url"]; }
  }
  $urlok = ($url === "/" || $url === "/node" || $url === "<front>" || $url === "/<front>");
  print (($found && $urlok) ? "PASS" : "FAIL")
    . " found=" . ($found ? 1 : 0) . " url=" . $url . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
