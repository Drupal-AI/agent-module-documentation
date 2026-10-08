#!/usr/bin/env bash
# Execution VERIFY: PASS when auto-block is set to idle 6 months, email on, and the block email
# subject is 'Account disabled due to inactivity'. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("block_inactive_users.settings");
  $idle = (string) $c->get("block_inactive_users_idle_time");
  $email = (bool) $c->get("block_inactive_users_send_email");
  $subj = (string) $c->get("block_inactive_users_email_subject");
  $ok = ($idle === "6") && $email && ($subj === "Account disabled due to inactivity");
  print ($ok ? "PASS" : "FAIL") . " idle=" . $idle . " email=" . var_export($email, TRUE) . " subject=" . $subj . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
