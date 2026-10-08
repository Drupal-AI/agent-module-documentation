#!/usr/bin/env bash
# Execution VERIFY: PASS when user_login_form is in the protected form_ids list. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = (string) \Drupal::config("simple_recaptcha.config")->get("form_ids");
  $list = array_map("trim", explode(",", $ids));
  $ok = in_array("user_login_form", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " form_ids=" . $ids . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
