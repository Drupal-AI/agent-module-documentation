#!/usr/bin/env bash
# Execution VERIFY: PASS when a menu link titled "Prepopulate Eval Link" exists in the main menu
# and its URL is /node/add/article carrying prepopulate query parameters that fill the title with
# "Campaign Update" and the body with "Draft copy". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)
    ->condition("title", "Prepopulate Eval Link")->execute();
  $ok = FALSE; $seen = "none";
  foreach (MenuLinkContent::loadMultiple($ids) as $link) {
    $url = urldecode($link->getUrlObject()->toString());
    $seen = $link->getMenuName() . " :: " . $url;
    $ok = $link->getMenuName() === "main"
      && str_contains($url, "/node/add/article")
      && str_contains($url, "edit[title][widget][0][value]=Campaign Update")
      && str_contains($url, "edit[body][widget][0][value]=Draft copy");
    if ($ok) { break; }
  }
  print ($ok ? "PASS" : "FAIL") . " link=" . $seen . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
