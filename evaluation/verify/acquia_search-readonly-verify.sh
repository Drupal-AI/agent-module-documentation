#!/usr/bin/env bash
# HARD execution verify (shared by the -layman and -expert cases):
# Acquia Search must be forced read-only AND pinned to core ABCD-12345.prod.mysite
# in acquia_search.settings. Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("acquia_search.settings");
  $ro = ($c->get("read_only") === TRUE || $c->get("read_only") === 1 || $c->get("read_only") === "1");
  $core = (string) $c->get("override_search_core");
  $ok = ($ro && $core === "ABCD-12345.prod.mysite");
  print ($ok ? "PASS" : "FAIL") . " read_only=" . var_export($c->get("read_only"), TRUE) . " core=" . $core . "\n";
' 2>/dev/null | grep -Ev '^\s*(Deprecated|Warning|Notice):' | grep -E '^(PASS|FAIL)')

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
