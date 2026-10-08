#!/usr/bin/env bash
# HARD execution verify: the PHP Sentry DSN (client_key) is set to the expected value,
# environment = production, and error + critical PHP log_levels are captured.
# Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html

EXPECTED_DSN='https://examplePublicKey@o0.ingest.sentry.io/0'

out=$(drush php:eval '
  $c = \Drupal::config("raven.settings");
  $dsn = $c->get("client_key") === "'"$EXPECTED_DSN"'";
  $env = $c->get("environment") === "production";
  $l = $c->get("log_levels");
  $lvl = !empty($l["error"]) && !empty($l["critical"]);
  print (($dsn && $env && $lvl) ? "PASS" : "FAIL") . " dsn=" . ($dsn?1:0) . " env=" . ($env?1:0) . " levels=" . ($lvl?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
