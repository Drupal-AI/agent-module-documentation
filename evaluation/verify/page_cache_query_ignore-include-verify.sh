#!/usr/bin/env bash
# Execution VERIFY: PASS when ignore_action is 'include' and query_parameters contains 'page'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("page_cache_query_ignore.settings");
  $p = $c->get("query_parameters") ?: [];
  $ok = ($c->get("ignore_action") === "include") && in_array("page", $p, TRUE);
  print ($ok ? "PASS" : "FAIL") . " action=" . var_export($c->get("ignore_action"), TRUE) . " params=" . implode(",", $p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
