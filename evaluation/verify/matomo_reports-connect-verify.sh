#!/usr/bin/env bash
# Execution VERIFY: PASS when the Matomo server URL is the required one and token_auth=anonymous.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("matomo_reports.matomoreportssettings");
  $url = $c->get("matomo_server_url");
  $tok = $c->get("matomo_reports_token_auth");
  $ok = ($url === "https://analytics.mtask.example.com/matomo/") && ($tok === "anonymous");
  print ($ok ? "PASS" : "FAIL") . " url=" . var_export($url,true) . " token=" . var_export($tok,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
