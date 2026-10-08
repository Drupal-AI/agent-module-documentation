#!/usr/bin/env bash
# Execution VERIFY: PASS when login_message === 'Members only. Please log in.' AND include_403 true.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("require_login.settings");
  $msg = trim((string) $c->get("login_message"));
  $i403 = $c->get("extra.include_403");
  $ok = ($msg === "Members only. Please log in.") && ($i403 === TRUE);
  print ($ok ? "PASS" : "FAIL") . " login_message=[" . $msg . "] include_403=" . var_export($i403, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
