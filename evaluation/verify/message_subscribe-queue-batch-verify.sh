#!/usr/bin/env bash
# Execution VERIFY (message_subscribe): PASS when message_subscribe.settings has use_queue === TRUE
# AND range === 50. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("message_subscribe.settings");
  $uq = $c->get("use_queue");
  $range = $c->get("range");
  $ok = ($uq === TRUE && (int) $range === 50);
  print ($ok ? "PASS" : "FAIL") . " use_queue=" . var_export($uq, TRUE) . " range=" . var_export($range, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
