#!/usr/bin/env bash
# Execution VERIFY: PASS when private_message.settings has enable_notifications === FALSE AND
# number_of_seconds_considered_away === 300. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("private_message.settings");
  $en = $c->get("enable_notifications");
  $away = $c->get("number_of_seconds_considered_away");
  $ok = ($en === FALSE && (int) $away === 300);
  print ($ok ? "PASS" : "FAIL") . " enable_notifications=" . var_export($en, TRUE) . " away=" . var_export($away, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
