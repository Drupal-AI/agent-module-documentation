#!/usr/bin/env bash
# Execution VERIFY: PASS when the layout_twocol "second" region has numeric_limit === 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("layout_paragraphs_limit.settings")->get("disallowed_types.layout_twocol.second");
  $n = $r["numeric_limit"] ?? NULL;
  print (($n === 1) ? "PASS" : "FAIL")." numeric_limit=".var_export($n,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
