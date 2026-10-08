#!/usr/bin/env bash
# Execution VERIFY: PASS when user.settings register === 'admin_only' and the user.register route
# is NOT accessible to anonymous users - so Better Login hides the register link. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $reg = \Drupal::config("user.settings")->get("register");
  $anon = \Drupal\user\Entity\User::getAnonymousUser();
  $access = \Drupal\Core\Url::fromRoute("user.register")->access($anon);
  $ok = ($reg === "admin_only" && $access === FALSE);
  print ($ok ? "PASS" : "FAIL") . " register=" . var_export($reg, TRUE) . " anon_can_register=" . var_export($access, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
