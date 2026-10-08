#!/usr/bin/env bash
# HARD verify: PASS iff datalayer.settings entity_meta includes both "uid" and
# "created" (order/extra values irrelevant). Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("datalayer.settings")->get("entity_meta") ?: [];
  $m = array_values(array_filter($m));
  $u = in_array("uid", $m, TRUE) ? 1 : 0;
  $c = in_array("created", $m, TRUE) ? 1 : 0;
  print "MARK " . (($u && $c) ? "PASS" : "FAIL") . " uid=$u created=$c list=" . implode(",", $m) . " MARK";
' 2>/dev/null | grep -oE 'MARK .* MARK')
out=${out#MARK }; out=${out% MARK}
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
