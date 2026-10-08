#!/usr/bin/env bash
# Execution VERIFY: PASS when field_nm_task's component in the default node.article view
# display carries third_party_settings.nomarkup.enabled === TRUE. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_nm_task") : NULL;
  $en = $c["third_party_settings"]["nomarkup"]["enabled"] ?? NULL;
  $ok = ($en === TRUE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
