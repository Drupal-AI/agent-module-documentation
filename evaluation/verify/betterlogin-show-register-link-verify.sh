#!/usr/bin/env bash
# Execution VERIFY: PASS when the user.register route is accessible to anonymous users - the exact
# condition Better Login uses to set register_url - i.e. user.settings register != 'admin_only'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $reg = \Drupal::config("user.settings")->get("register");
  $anon = \Drupal\user\Entity\User::getAnonymousUser();
  $access = \Drupal\Core\Url::fromRoute("user.register")->access($anon);
  $ok = ($access === TRUE && $reg !== "admin_only");
  print ($ok ? "PASS" : "FAIL") . " register=" . var_export($reg, TRUE) . " anon_can_register=" . var_export($access, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
