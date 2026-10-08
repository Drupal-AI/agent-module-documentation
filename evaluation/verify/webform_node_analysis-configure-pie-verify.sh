#!/usr/bin/env bash
# Execution VERIFY: PASS when wanalysis_fixture webform_analysis chart_type=PieChart and components
# includes 'newsletter'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::entityTypeManager()->getStorage("webform")->load("wanalysis_fixture");
  $ct = $w ? (string) $w->getThirdPartySetting("webform_analysis","chart_type") : "";
  $comp = $w ? (array) $w->getThirdPartySetting("webform_analysis","components") : [];
  $ok = ($ct === "PieChart" && in_array("newsletter", $comp, TRUE));
  print ($ok ? "PASS" : "FAIL") . " chart_type=$ct components=" . implode(",", $comp) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
