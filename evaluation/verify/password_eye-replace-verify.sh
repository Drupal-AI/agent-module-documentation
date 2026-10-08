#!/usr/bin/env bash
# Execution VERIFY: PASS when the target list includes 'comment_comment_form' AND no longer
# includes 'user_login_form'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("password_eye.settings")->get("password_eye.form_id_password");
  $ids = array_map("trim", explode(",", $v));
  $ok = in_array("comment_comment_form", $ids, TRUE) && !in_array("user_login_form", $ids, TRUE);
  print ($ok ? "PASS" : "FAIL") . " value=" . $v . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
