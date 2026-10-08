#!/usr/bin/env bash
# Execution VERIFY: PASS when an account exists with mail ru_new2@example.com whose name equals
# that email, and NO account with mail ru_task2@example.com remains. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $new = user_load_by_mail("ru_new2@example.com");
  $old = user_load_by_mail("ru_task2@example.com");
  $name = $new ? $new->getAccountName() : NULL;
  $ok = ($new && $name === "ru_new2@example.com" && !$old);
  print ($ok ? "PASS" : "FAIL") . " new=" . ($new ? "yes" : "no") . " name=" . var_export($name, TRUE) . " old_gone=" . ($old ? "no" : "yes") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
