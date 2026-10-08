#!/usr/bin/env bash
# Execution VERIFY: PASS when the Footnotes filter on footnotes_eval is enabled AND its
# footnotes_footer_disable setting is TRUE (inline footer suppressed).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("filter.format.footnotes_eval");
  $st = $f->get("filters.filter_footnotes.status");
  $fd = $f->get("filters.filter_footnotes.settings.footnotes_footer_disable");
  $ok = ($st === TRUE && $fd === TRUE);
  print (($ok) ? "PASS" : "FAIL") . " status=" . var_export($st,TRUE) . " footer_disable=" . var_export($fd,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
