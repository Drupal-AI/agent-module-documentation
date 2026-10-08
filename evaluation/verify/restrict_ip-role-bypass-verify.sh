#!/usr/bin/env bash
# Execution VERIFY: PASS when restrict_ip.settings has allow_role_bypass===TRUE AND
# bypass_action==='redirect_login_page'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("restrict_ip.settings");
  $b = $c->get("allow_role_bypass");
  $a = $c->get("bypass_action");
  $ok = ($b === TRUE && $a === "redirect_login_page");
  print ($ok ? "PASS" : "FAIL") . " allow_role_bypass=" . var_export($b, TRUE) . " bypass_action=" . var_export($a, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
