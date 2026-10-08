#!/usr/bin/env bash
# Live-state verification for "configure Drupical to show 10 events, cache 1 hour, cron 1 hour".
# PASS when drupical.settings has limit=10, max_age=3600, cron_interval=3600. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("drupical.settings");
  $limit = (int) $c->get("limit"); $max = (int) $c->get("max_age"); $cron = (int) $c->get("cron_interval");
  $ok = ($limit === 10 && $max === 3600 && $cron === 3600);
  print ($ok ? "PASS" : "FAIL") . " limit=$limit max_age=$max cron_interval=$cron\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
