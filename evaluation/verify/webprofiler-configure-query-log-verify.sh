#!/usr/bin/env bash
# Execution VERIFY: PASS when query_sort===duration AND query_highlight===20.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("webprofiler.settings");
  $ok = ($c->get("query_sort") === "duration") && ((int) $c->get("query_highlight") === 20);
  print ($ok ? "PASS" : "FAIL") . " sort=" . var_export($c->get("query_sort"),TRUE) . " highlight=" . var_export($c->get("query_highlight"),TRUE);
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
