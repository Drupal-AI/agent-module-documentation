#!/usr/bin/env bash
# HARD execution verify: SearchStax must be configured to route live searches through
# SearchStudio (searches_via_searchstudio = TRUE) AND carry the global analytics key
# "AK-EVAL-9000". Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
# Config-only check — no SearchStax network access required.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("searchstax.settings");
  $r = ($c->get("searches_via_searchstudio") === TRUE || $c->get("searches_via_searchstudio") === 1 || $c->get("searches_via_searchstudio") === "1");
  $key = (string) $c->get("analytics_key");
  $ok = ($r && $key === "AK-EVAL-9000");
  print ($ok ? "PASS" : "FAIL") . " searches_via_searchstudio=" . var_export($c->get("searches_via_searchstudio"), TRUE) . " analytics_key=" . $key . "\n";
' 2>/dev/null | grep -Ev "^\s*(Deprecated|Warning|Notice):" | grep -E "^(PASS|FAIL)")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
