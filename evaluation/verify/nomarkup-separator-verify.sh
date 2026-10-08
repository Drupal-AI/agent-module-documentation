#!/usr/bin/env bash
# Execution VERIFY: PASS when field_nm_sep's component in the default node.article view
# display has nomarkup.enabled === TRUE AND nomarkup.separator === " / ". Prints PASS/FAIL;
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_nm_sep") : NULL;
  $tp = $c["third_party_settings"]["nomarkup"] ?? [];
  $en = $tp["enabled"] ?? NULL;
  $sep = $tp["separator"] ?? NULL;
  $ok = ($en === TRUE && $sep === " / ");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . " separator=" . var_export($sep, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
