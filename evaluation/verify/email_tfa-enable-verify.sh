#!/usr/bin/env bash
# Execution VERIFY: PASS when Email TFA is enabled globally, i.e. email_tfa.settings:status === TRUE
# AND tracks === 'globally_enabled'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("email_tfa.settings");
  $s = $c->get("status"); $t = $c->get("tracks");
  $ok = (($s === TRUE || $s === 1 || $s === "1") && $t === "globally_enabled");
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($s, TRUE) . " tracks=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
