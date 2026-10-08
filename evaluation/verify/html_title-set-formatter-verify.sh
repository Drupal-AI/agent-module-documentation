#!/usr/bin/env bash
# Execution VERIFY: PASS when field_hty_task's component in the Article default view display
# uses the html_title formatter. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_hty_task") : NULL;
  $type = $c["type"] ?? "none";
  print (($type === "html_title") ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
