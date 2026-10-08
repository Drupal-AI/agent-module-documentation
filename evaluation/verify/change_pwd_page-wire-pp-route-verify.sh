#!/usr/bin/env bash
# Execution VERIFY: PASS when change_password_route is the change_pwd_page separate FORM route. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("password_policy.settings")->get("change_password_route");
  $ok = ($v === "change_pwd_page.change_password_form");
  print ($ok ? "PASS" : "FAIL") . " route=" . $v . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
