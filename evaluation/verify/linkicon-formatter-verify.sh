#!/usr/bin/env bash
# Execution VERIFY: PASS when field_li_task's component in the default view display uses the
# 'linkicon' formatter with linkicon_prefix === 'bi'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_li_task") : NULL;
  $type = $c["type"] ?? "none";
  $prefix = $c["settings"]["linkicon_prefix"] ?? NULL;
  $ok = ($type === "linkicon" && $prefix === "bi");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " prefix=" . var_export($prefix, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
