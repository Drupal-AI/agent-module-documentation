#!/usr/bin/env bash
# Live-state verification for "make 'FA Eval Social' show ONLY a GitHub brand icon (no
# text)". Reads the menu_link_content entity's link options and requires:
#   fa_icon             non-empty and references github (contains github)
#   fa_icon_prefix      a brands style (fa-brands or fab)
#   fa_icon_appearance  only   (icon replaces the text)
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("menu_link_content")
    ->getQuery()->accessCheck(FALSE)->condition("title", "FA Eval Social")->execute();
  $ok = FALSE; $icon = ""; $prefix = ""; $app = "";
  foreach (\Drupal\menu_link_content\Entity\MenuLinkContent::loadMultiple($ids) as $ml) {
    $o = $ml->link->first()->options ?: [];
    $icon = strtolower($o["fa_icon"] ?? "");
    $prefix = strtolower($o["fa_icon_prefix"] ?? "");
    $app = strtolower($o["fa_icon_appearance"] ?? "before");
    $iconok = ($icon !== "" && strpos($icon, "github") !== FALSE);
    $prefixok = in_array($prefix, ["fa-brands", "fab"], TRUE);
    $appok = ($app === "only");
    if ($iconok && $prefixok && $appok) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " icon=" . $icon . " prefix=" . $prefix . " appearance=" . $app . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -qa '^PASS' && exit 0 || exit 1
