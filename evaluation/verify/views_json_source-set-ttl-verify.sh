#!/usr/bin/env bash
# Execution VERIFY: PASS when views_json_source.settings cache_ttl === 3600. Exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("views_json_source.settings")->get("cache_ttl");
  $ok = ((int) $v === 3600);
  print ($ok ? "PASS" : "FAIL") . " cache_ttl=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
