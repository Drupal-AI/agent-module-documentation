#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled entity_view_display menu_link_content.menu_link_content.mif_hero
# exists. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("menu_link_content.menu_link_content.mif_hero");
  $ok = ($vd && $vd->status());
  print ($ok ? "PASS" : "FAIL") . " display=" . ($vd ? ("exists status=" . var_export($vd->status(), TRUE)) : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
