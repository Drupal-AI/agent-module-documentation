#!/usr/bin/env bash
# Execution VERIFY: PASS when the Footnotes filter is enabled on filter.format.footnotes_eval.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("filter.format.footnotes_eval");
  $st = $f->get("filters.filter_footnotes.status");
  print (($st === TRUE) ? "PASS" : "FAIL") . " status=" . var_export($st,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
