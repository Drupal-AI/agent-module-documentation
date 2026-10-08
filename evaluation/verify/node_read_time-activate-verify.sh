#!/usr/bin/env bash
# Execution VERIFY: PASS when reading time is activated for the Article node type
# (reading_time.container.article.is_activated is truthy). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rt = \Drupal::config("node_read_time.settings")->get("reading_time");
  $v = $rt["container"]["article"]["is_activated"] ?? 0;
  $ok = (bool) $v;
  print ($ok ? "PASS" : "FAIL") . " article.is_activated=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
