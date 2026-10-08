#!/usr/bin/env bash
# Execution VERIFY (sdc_display): PASS when the Article default view display has sdc_display
# enabled === TRUE and component.machine_name === "olivero:teaser". Read-only. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $g = $vd ? $vd->getThirdPartySettings("sdc_display") : [];
  $en = $g["enabled"] ?? NULL;
  $comp = $g["component"]["machine_name"] ?? NULL;
  $ok = (($en === TRUE || $en === 1 || $en === "1") && $comp === "olivero:teaser");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . " component=" . var_export($comp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
