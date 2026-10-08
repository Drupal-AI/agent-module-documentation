#!/usr/bin/env bash
# Execution VERIFY for "nest the Cameras term link under the existing Shop link".
# PASS when a menu_link_content in tmui_shop_menu points at internal:/taxonomy/term/<Cameras
# tid> and its parent is the plugin id of the existing 'Shop' link
# (menu_link_content:<Shop uuid>) — the value taxonomy_menu_ui derives from the term form's
# `menu_parent` select. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $terms = $ts->loadByProperties(["vid" => "tmui_shop", "name" => "Cameras"]);
  $term = $terms ? reset($terms) : NULL;
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $shopLinks = $mlc->loadByProperties(["menu_name" => "tmui_shop_menu", "title" => "Shop"]);
  $shop = $shopLinks ? reset($shopLinks) : NULL;
  $expected = $shop ? "menu_link_content:" . $shop->uuid() : NULL;
  $link = NULL;
  if ($term) {
    $found = $mlc->loadByProperties([
      "menu_name" => "tmui_shop_menu",
      "link__uri" => "internal:/taxonomy/term/" . $term->id(),
    ]);
    $link = $found ? reset($found) : NULL;
  }
  $parent = $link ? $link->getParentId() : NULL;
  $ok = $term && $shop && $link && $expected !== NULL && $parent === $expected;
  print ($ok ? "PASS" : "FAIL")
    . " term=" . ($term ? "tid" . $term->id() : "missing")
    . " shop=" . ($shop ? "present" : "missing")
    . " link=" . ($link ? "present" : "missing")
    . " parent=" . var_export($parent, TRUE)
    . " expected=" . var_export($expected, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
