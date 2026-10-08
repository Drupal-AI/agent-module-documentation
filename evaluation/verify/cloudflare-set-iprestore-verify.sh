#!/usr/bin/env bash
# Execution VERIFY: PASS when client_ip_restore_enabled=true AND bypass_host=origin.example.com.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("cloudflare.settings");
  $ok = ($c->get("client_ip_restore_enabled") === TRUE) && ($c->get("bypass_host") === "origin.example.com");
  print ($ok ? "PASS" : "FAIL") . " client_ip_restore_enabled=" . var_export($c->get("client_ip_restore_enabled"), TRUE) . " bypass_host=" . $c->get("bypass_host") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
