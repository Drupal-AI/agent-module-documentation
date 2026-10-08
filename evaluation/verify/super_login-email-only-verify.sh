#!/usr/bin/env bash
# Execution VERIFY: PASS when Super Login is email-only (login_type===2) AND the caps-lock
# warning is off (capslock falsey). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("super_login.settings");
  $lt = (int) $c->get("super_login.login_type");
  $cl = $c->get("super_login.capslock");
  $ok = ($lt === 2 && !$cl);
  print ($ok ? "PASS" : "FAIL") . " login_type=" . $lt . " capslock=" . var_export($cl, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
