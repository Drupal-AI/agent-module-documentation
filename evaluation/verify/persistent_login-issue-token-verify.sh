#!/usr/bin/env bash
# Execution VERIFY: PASS when the account pl_task_user has exactly one active (non-expired)
# persistent login token, checked both through the module's token manager and directly in the
# persistent_login table. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = user_load_by_name("pl_task_user");
  if (!$u) { print "FAIL user=missing\n"; return; }
  $tokens = \Drupal::service("persistent_login.token_manager")->getTokensForUser($u);
  $rows = (int) \Drupal::database()->select("persistent_login", "pl")
    ->condition("uid", $u->id())
    ->countQuery()->execute()->fetchField();
  $ok = (count($tokens) === 1) && ($rows === 1);
  print ($ok ? "PASS" : "FAIL") . " active_tokens=" . count($tokens) . " table_rows=" . $rows . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
