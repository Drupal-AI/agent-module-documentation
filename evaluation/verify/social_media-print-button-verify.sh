#!/usr/bin/env bash
# HARD verify: PASS iff the Print network is enabled, fires window.print() and is wired
# as a JS onclick action (api_event=onclick). Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("social_media.settings")->get("social_media");
  $p = $m["print"] ?? [];
  $en    = (isset($p["enable"]) && $p["enable"]) ? 1 : 0;
  $click = (($p["api_event"] ?? "") === "onclick") ? 1 : 0;
  $fn    = (stripos($p["api_url"] ?? "", "window.print()") !== FALSE) ? 1 : 0;
  print "MARK " . (($en && $click && $fn) ? "PASS" : "FAIL") . " enable=$en onclick=$click print=$fn MARK";
' 2>/dev/null | grep -oE 'MARK .* MARK')
out=${out#MARK }; out=${out% MARK}
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
