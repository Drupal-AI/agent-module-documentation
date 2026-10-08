#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ef_pop in the Article default view display uses the
# editablefields_formatter with popup behaviour. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ef_pop") : NULL;
  $type = $c["type"] ?? "none";
  $beh = $c["settings"]["behaviour"] ?? "";
  $ok = ($type === "editablefields_formatter" && $beh === "popup");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " behaviour=" . var_export($beh, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
