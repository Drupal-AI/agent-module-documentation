#!/usr/bin/env bash
# Live-state verification for the "set forum topics-per-page to 30 and hot-topic threshold
# to 20" task. Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when forum.settings has topics.page_limit == 30 AND topics.hot_threshold == 20.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("forum.settings");
  $pl = (int) $c->get("topics.page_limit");
  $ht = (int) $c->get("topics.hot_threshold");
  $ok = $pl === 30 && $ht === 20;
  print (($ok ? "PASS" : "FAIL") . " page_limit=$pl hot_threshold=$ht\n");
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
