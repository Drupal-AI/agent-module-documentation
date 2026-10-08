#!/usr/bin/env bash
# Live-state verification for the "add a 'Contact Us' link to the FOOTER menu" task.
# PASS when simplify_menu's service returns a link with text "Contact Us" in the 'footer'
# menu tree (getMenuTree('footer')) AND that link is NOT present in the 'main' menu tree —
# proving the agent placed it in the footer specifically. Rebuilds links + clears menu cache
# first. Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  \Drupal::cache("menu")->deleteAll();
  $svc = \Drupal::service("simplify_menu.menu_items");
  $has = function(array $tree, string $text): bool {
    foreach ($tree as $i) { if ($i["text"] === $text) { return TRUE; } }
    return FALSE;
  };
  $inFooter = $has($svc->getMenuTree("footer")["menu_tree"], "Contact Us");
  $inMain   = $has($svc->getMenuTree("main")["menu_tree"], "Contact Us");
  print (($inFooter && !$inMain) ? "PASS" : "FAIL")
    . " footer=" . ($inFooter ? 1 : 0) . " main=" . ($inMain ? 1 : 0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
