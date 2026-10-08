#!/usr/bin/env bash
# Execution VERIFY: PASS when custom_field_sdc component rendering is NOT active on the
# cfsdc_eval default view display (settings absent OR enabled not true). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.cfsdc_eval.default");
  $s=$vd ? $vd->getThirdPartySetting("custom_field_sdc","settings") : NULL;
  $en=is_array($s) ? ($s["enabled"] ?? NULL) : NULL;
  $ok=($en !== TRUE);
  print ($ok?"PASS":"FAIL")." settings=".json_encode($s)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
