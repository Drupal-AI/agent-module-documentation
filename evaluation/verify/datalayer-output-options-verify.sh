#!/usr/bin/env bash
# HARD verify: PASS iff both output_terms and output_fields are enabled in
# datalayer.settings on the live site. Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("datalayer.settings");
  $t = $c->get("output_terms") ? 1 : 0;
  $f = $c->get("output_fields") ? 1 : 0;
  print "MARK " . (($t && $f) ? "PASS" : "FAIL") . " terms=$t fields=$f MARK";
' 2>/dev/null | grep -oE 'MARK .* MARK')
out=${out#MARK }; out=${out% MARK}
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
