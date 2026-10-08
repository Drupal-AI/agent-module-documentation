#!/usr/bin/env bash
# Execution VERIFY: PASS when reading_time.words_per_minute === 150. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rt = \Drupal::config("node_read_time.settings")->get("reading_time");
  $v = $rt["words_per_minute"] ?? NULL;
  $ok = ((int) $v === 150);
  print ($ok ? "PASS" : "FAIL") . " words_per_minute=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
