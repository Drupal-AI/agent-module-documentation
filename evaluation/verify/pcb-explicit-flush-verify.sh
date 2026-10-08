#!/usr/bin/env bash
# Execution VERIFY: PASS when the pcb_clear bin no longer holds pcb_ckey (it was explicitly
# flushed). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $item = \Drupal::service("cache.backend.permanent_database")->get("pcb_clear")->get("pcb_ckey");
  $ok = ($item === FALSE);
  print ($ok ? "PASS" : "FAIL") . " item=" . ($item ? var_export($item->data, TRUE) : "MISS") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
