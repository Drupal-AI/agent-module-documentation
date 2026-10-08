#!/usr/bin/env bash
# Execution VERIFY: PASS when ignore_action is 'exclude' and query_parameters contains BOTH
# gclid and utm_source. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("page_cache_query_ignore.settings");
  $p = $c->get("query_parameters") ?: [];
  $ok = ($c->get("ignore_action") === "exclude") && in_array("gclid", $p, TRUE) && in_array("utm_source", $p, TRUE);
  print ($ok ? "PASS" : "FAIL") . " action=" . var_export($c->get("ignore_action"), TRUE) . " params=" . implode(",", $p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
