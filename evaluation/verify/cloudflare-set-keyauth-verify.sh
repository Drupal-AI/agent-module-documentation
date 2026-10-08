#!/usr/bin/env bash
# Execution VERIFY: PASS when auth_using=key AND apikey=ABC123KEY AND email=api-admin@example.com.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("cloudflare.settings");
  $ok = ($c->get("auth_using") === "key") && ($c->get("apikey") === "ABC123KEY") && ($c->get("email") === "api-admin@example.com");
  print ($ok ? "PASS" : "FAIL") . " auth_using=" . $c->get("auth_using") . " apikey=" . $c->get("apikey") . " email=" . $c->get("email") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
