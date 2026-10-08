#!/usr/bin/env bash
# Execution VERIFY: PASS when password_eye's target form list includes 'user_register_form'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("password_eye.settings")->get("password_eye.form_id_password");
  $ids = array_map("trim", explode(",", $v));
  $ok = in_array("user_register_form", $ids, TRUE);
  print ($ok ? "PASS" : "FAIL") . " value=" . $v . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
