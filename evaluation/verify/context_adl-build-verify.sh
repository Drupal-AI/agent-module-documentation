#!/usr/bin/env bash
# Execution VERIFY: PASS when Context cadl_hard has a context_advanced_datalayer reaction whose
# site_Name datalayer value === 'HardCtx'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("context.context.cadl_hard")->get("reactions.context_advanced_datalayer");
  $v = is_array($r) ? ($r["site_Name"] ?? NULL) : NULL;
  print (($v === "HardCtx") ? "PASS" : "FAIL") . " site_Name=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
