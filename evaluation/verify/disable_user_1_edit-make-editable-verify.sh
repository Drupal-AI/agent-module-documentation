#!/usr/bin/env bash
# Execution VERIFY: PASS when the disable_user_1_edit restriction is OFF - config disabled=1 AND the
# module's access hook no longer forbids access to user 1. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $disabled = (int) \Drupal::config("disable_user_1_edit.settings")->get("disabled");
  $u1 = \Drupal\user\Entity\User::load(1);
  $res = disable_user_1_edit_user_access($u1, "update", \Drupal::currentUser());
  $not_forbidden = !$res->isForbidden();
  $ok = ($disabled === 1 && $not_forbidden);
  print ($ok ? "PASS" : "FAIL") . " disabled=" . $disabled . " hook_forbidden=" . ($res->isForbidden()?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
