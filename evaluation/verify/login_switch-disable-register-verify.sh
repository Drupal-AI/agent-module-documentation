#!/usr/bin/env bash
# Execution VERIFY: PASS when the register route is fully disabled (denied): register_disabled
# TRUE and register_route empty.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("login_switch.settings");
  $ok = ($c->get("register_disabled") === TRUE) && ($c->get("register_route") === "");
  print ($ok ? "PASS" : "FAIL") . " disabled=" . var_export($c->get("register_disabled"),TRUE) . " route=" . var_export($c->get("register_route"),TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
