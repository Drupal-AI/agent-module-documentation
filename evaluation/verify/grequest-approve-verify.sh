#!/usr/bin/env bash
# Execution VERIFY: PASS when grequest_approve_user is now a member of the grequest_atype group
# (i.e. the request was approved). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = user_load_by_name("grequest_approve_user");
  $groups = \Drupal::entityTypeManager()->getStorage("group")->loadByProperties(["type"=>"grequest_atype"]);
  $g = $groups ? reset($groups) : NULL;
  $ok = ($u && $g && $g->getMember($u));
  print ($ok ? "PASS" : "FAIL") . " is_member=" . ($ok ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
