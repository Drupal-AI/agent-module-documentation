#!/usr/bin/env bash
# Live-state verification for "put a solid house/home icon BEFORE the text on the menu link
# titled 'FA Eval Target'". Reads the menu_link_content entity's link options and requires:
#   fa_icon             non-empty and looks like a house/home icon (contains house|home)
#   fa_icon_prefix      a solid style (fa-solid or fas)
#   fa_icon_appearance  before  (default is also "before", so an explicit icon is what matters)
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("menu_link_content")
    ->getQuery()->accessCheck(FALSE)->condition("title", "FA Eval Target")->execute();
  $ok = FALSE; $icon = ""; $prefix = ""; $app = "";
  foreach (\Drupal\menu_link_content\Entity\MenuLinkContent::loadMultiple($ids) as $ml) {
    $o = $ml->link->first()->options ?: [];
    $icon = strtolower($o["fa_icon"] ?? "");
    $prefix = strtolower($o["fa_icon_prefix"] ?? "");
    $app = strtolower($o["fa_icon_appearance"] ?? "before");
    $iconok = ($icon !== "" && (strpos($icon, "house") !== FALSE || strpos($icon, "home") !== FALSE));
    $prefixok = in_array($prefix, ["fa-solid", "fas"], TRUE);
    $appok = ($app === "before");
    if ($iconok && $prefixok && $appok) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " icon=" . $icon . " prefix=" . $prefix . " appearance=" . $app . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -qa '^PASS' && exit 0 || exit 1
