#!/usr/bin/env bash
# HARD execution verify (shared by the -layman and -expert cases):
# SearchStax flood protection must be ENABLED with a per-IP search limit of 5 requests
# per 30-second window. Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
# Config-only check — no SearchStax network access required.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("searchstax.settings");
  $en = ($c->get("flood_protection.enabled") === TRUE || $c->get("flood_protection.enabled") === 1 || $c->get("flood_protection.enabled") === "1");
  $lim = (int) $c->get("flood_protection.search_limit");
  $win = (int) $c->get("flood_protection.search_window");
  $ok = ($en && $lim === 5 && $win === 30);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($c->get("flood_protection.enabled"), TRUE) . " search_limit=" . $lim . " search_window=" . $win . "\n";
' 2>/dev/null | grep -Ev "^\s*(Deprecated|Warning|Notice):" | grep -E "^(PASS|FAIL)")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
