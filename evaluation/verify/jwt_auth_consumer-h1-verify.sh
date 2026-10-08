#!/usr/bin/env bash
# Execution VERIFY for "enable jwt_auth_consumer so the site accepts issuer tokens". PASS iff
# core.extension lists jwt_auth_consumer AND the container has service
# jwt_auth_consumer.subscriber. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
enabled=$(drush php:eval '
  $mods = \Drupal::config("core.extension")->get("module");
  print (isset($mods["jwt_auth_consumer"]) ? "yes" : "no") . "\n";
' 2>/dev/null | tr -d '\r')
service=$(drush php:eval '
  print (\Drupal::hasService("jwt_auth_consumer.subscriber") ? "yes" : "no") . "\n";
' 2>/dev/null | tr -d '\r')
ok="no"
if [ "$enabled" = "yes" ] && [ "$service" = "yes" ]; then ok="yes"; fi
echo "$([ "$ok" = "yes" ] && echo PASS || echo FAIL) module_enabled=$enabled service_present=$service"
[ "$ok" = "yes" ] && exit 0 || exit 1
