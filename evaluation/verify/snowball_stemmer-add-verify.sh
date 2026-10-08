#!/usr/bin/env bash
# Execution VERIFY: PASS when the snowball_stemmer processor is enabled on index ss_task
# (present in processor_settings config). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ps = \Drupal::config("search_api.index.ss_task")->get("processor_settings") ?? [];
  $ok = array_key_exists("snowball_stemmer", $ps);
  print ($ok ? "PASS" : "FAIL") . " snowball_enabled=" . ($ok ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
