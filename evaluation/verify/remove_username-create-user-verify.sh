#!/usr/bin/env bash
# Execution VERIFY: PASS when a user exists whose mail is ru_task@example.com AND whose name
# equals that email (remove_username's email-as-username rule). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = user_load_by_mail("ru_task@example.com");
  $name = $u ? $u->getAccountName() : NULL;
  $ok = ($u && $name === "ru_task@example.com");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($u ? "yes" : "no") . " name=" . var_export($name, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
