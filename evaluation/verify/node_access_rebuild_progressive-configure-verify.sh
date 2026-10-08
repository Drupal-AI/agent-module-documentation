#!/usr/bin/env bash
# Execution VERIFY: PASS when cron===true AND chunk===50. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("node_access_rebuild_progressive.settings");
  $cron = $c->get("cron"); $chunk = $c->get("chunk");
  $ok = ($cron === TRUE && (int) $chunk === 50);
  print ($ok ? "PASS" : "FAIL") . " cron=" . var_export($cron, TRUE) . " chunk=" . var_export($chunk, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
