#!/usr/bin/env bash
# Execution VERIFY: render a sample table (empty corner th, one column header, one row header)
# through the thsa_render format and PASS only when the module produced scope="col" on the
# column header, scope="row" on the row header, and demoted the empty <th> (no empty <th> left).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $html = "<table><thead><tr><th></th><th>H1</th></tr></thead><tbody><tr><th>R1</th><td>V</td></tr></tbody></table>";
  $o = (string) check_markup($html, "thsa_render");
  $has_col = strpos($o, "scope=\"col\"") !== FALSE;
  $has_row = strpos($o, "scope=\"row\"") !== FALSE;
  $empty_gone = strpos($o, "<th></th>") === FALSE;
  $ok = $has_col && $has_row && $empty_gone;
  print ($ok ? "PASS" : "FAIL") . " col=" . var_export($has_col,TRUE) . " row=" . var_export($has_row,TRUE) . " empty_gone=" . var_export($empty_gone,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
