#!/usr/bin/env bash
# Execution VERIFY: PASS when the Cancel Users tool is set to idle 12 months and method
# user_cancel_block. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("block_inactive_users.settings_cancel_users");
  $idle = (string) $c->get("block_inactive_users_idle_time");
  $method = (string) $c->get("block_inactive_users_disable_account_method");
  $ok = ($idle === "12") && ($method === "user_cancel_block");
  print ($ok ? "PASS" : "FAIL") . " idle=" . $idle . " method=" . $method . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
