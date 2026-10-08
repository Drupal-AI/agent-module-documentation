#!/usr/bin/env bash
# Execution VERIFY: PASS when the SP certificate and private key file paths are configured in
# saml_sp.settings as requested. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("saml_sp.settings");
  $cert = (string) $c->get("cert_location"); $key = (string) $c->get("key_location");
  $ok = ($cert === "/etc/saml/sp.crt" && $key === "/etc/saml/sp.key");
  print ((($ok) ? "PASS" : "FAIL")." cert=".$cert." key=".$key."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
