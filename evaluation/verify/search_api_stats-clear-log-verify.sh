#!/usr/bin/env bash
# Execution VERIFY: PASS when no marker rows remain (agent cleared the log for s_name=sasclear,
# e.g. DELETE FROM search_api_stats or a scoped delete). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = (int) \Drupal::database()->select("search_api_stats","s")->condition("s.s_name","sasclear")->countQuery()->execute()->fetchField();
  print ($n === 0 ? "PASS" : "FAIL") . " sasclear_rows=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
