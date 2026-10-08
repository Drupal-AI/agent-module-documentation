#!/usr/bin/env bash
# Live-state verification for the "disable the password-reset flow" task. Two checks:
#   cfg    — noreqnewpass.settings_form:noreqnewpass_disable is TRUE
#   route  — the core user.pass route now has _access requirement 'FALSE' (denied)
# Prints PASS/FAIL; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = (bool) \Drupal::config("noreqnewpass.settings_form")->get("noreqnewpass_disable");
  \Drupal::service("router.builder")->rebuildIfNeeded();
  $route = \Drupal::service("router.route_provider")->getRouteByName("user.pass");
  $denied = $route && $route->getRequirement("_access") === "FALSE";
  print (($cfg && $denied) ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " route_denied=" . ($denied?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
