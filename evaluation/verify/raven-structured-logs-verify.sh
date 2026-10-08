#!/usr/bin/env bash
# HARD execution verify: Sentry structured logs are enabled AND error-and-above
# (error, critical, alert, emergency) logs_log_levels are captured.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("raven.settings");
  $enabled = $c->get("enable_logs") === TRUE;
  $l = $c->get("logs_log_levels");
  $error = !empty($l["error"]) && !empty($l["critical"]) && !empty($l["alert"]) && !empty($l["emergency"]);
  print (($enabled && $error) ? "PASS" : "FAIL") . " enable_logs=" . ($enabled?1:0) . " error+=" . ($error?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
