#!/usr/bin/env bash
# Execution VERIFY: PASS when cache_tag_excludelist contains the 'user:' prefix.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::config("cloudflarepurger.settings")->get("cache_tag_excludelist") ?? [];
  $ok = in_array("user:", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " cache_tag_excludelist=" . json_encode(array_values($list)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
