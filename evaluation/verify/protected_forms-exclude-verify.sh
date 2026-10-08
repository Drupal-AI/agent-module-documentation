#!/usr/bin/env bash
# Execution VERIFY: PASS when protected_forms excluded_forms contains 'pf_custom_form'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $pf=\Drupal::config("protected_forms.settings")->get("protected_forms") ?: [];
  $ex=(array)($pf["excluded_forms"] ?? []);
  $ok=in_array("pf_custom_form",$ex,TRUE);
  print ($ok ? "PASS" : "FAIL") . " excluded_forms=" . implode(",", $ex) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
