#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fs_display's component in the Article default view display
# uses the fivestar_rating formatter. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $vd->getComponent("field_fs_display");
  $type = $c["type"] ?? "none";
  $ok = ($type === "fivestar_rating");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
