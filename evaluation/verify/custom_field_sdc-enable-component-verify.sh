#!/usr/bin/env bash
# Execution VERIFY: PASS when the cfsdc_eval default view display has custom_field_sdc settings
# with enabled===true and component==='navigation:badge'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.cfsdc_eval.default");
  $s=$vd ? ($vd->getThirdPartySetting("custom_field_sdc","settings") ?? []) : [];
  $en=$s["enabled"] ?? NULL; $comp=$s["component"] ?? NULL;
  $ok=($en===TRUE && $comp==="navigation:badge");
  print ($ok?"PASS":"FAIL")." enabled=".var_export($en,true)." component=".var_export($comp,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
